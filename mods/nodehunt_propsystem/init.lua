
propsystem = {}


propsystem.vaild_nodes = {}

propsystem.player_old_properties = {}


-- Get all valid nodes that players can hide as, this is to support mods that add extra nodes aside for our basic nodes.
-- For now this is nodes that fully fill the node
core.register_on_mods_loaded(function()
for nodeName, node in pairs(core.registered_nodes) do
		if node.drawtype == "normal" or node.drawtype == "glasslike"  or node.drawtype == "glasslike_framed"  or node.drawtype == "glasslike_framed_optional" or node.drawtype == "allfaces"  or node.drawtype == "allfaces_optional" then 
			propsystem.vaild_nodes[nodeName] = true
		end
end
end)


-- Sets a players model and texture to the same as a node, currently only supports full node nodes
function propsystem.set_player_node(player,node)
	core.log(node)
	if propsystem.vaild_nodes[node] == nil then
		return false
	end
	
	propsystem.player_old_properties[player:get_player_name()] = player:get_properties()
	
	player:set_properties({
	mesh = "node.obj",
	textures = core.registered_nodes[node].tiles,
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5, z = 0.5},
	collisionbox = {-0.49,-0.49,-0.49,0.49,0.49,0.49},
	stepheight = 0.6,
	eye_height = 0.5,
	})
	return true
end


function propsystem.make_player_normal(player)

	if propsystem.player_old_properties[player:get_player_name()] == nil then
		--Reset player to default model if we don't have any other info. This default is from the player_api in minetest_game
		player:set_properties({
			mesh = "character.b3d",
			animation_speed = 30,
			textures = {"character.png"},
			visual = "mesh",
			visual_size = {x = 1, y = 1},
			animations = {
				stand     = {x = 0,   y = 79},
				walk      = {x = 168, y = 187},
				mine      = {x = 189, y = 198},
				walk_mine = {x = 200, y = 219},
				},
			collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
			stepheight = 0.6,
			eye_height = 1.47,
		})
	else
		player:set_properties(propsystem.player_old_properties[player:get_player_name()])
		propsystem.player_old_properties[player:get_player_name()] = nil
	end

end


core.register_on_joinplayer(function(player)
	propsystem.make_player_normal(player)
end)


core.register_chatcommand("debug_prop",{
    params = "<name> <node>",
    -- Short parameter description.  See the below note.

    description = "",
    -- General description of the command's purpose.

    privs = {debug = true},
    -- Required privileges to run. See `core.check_player_privs()` for
    -- the format and see [Privileges] for an overview of privileges.

    func = function(name, node)
	if propsystem.set_player_node(core.get_player_by_name(name),node) then
		core.log("Your are now a "..node)
	end
	end
	})
	
core.register_chatcommand("debug_normal",{
    params = "<name>",
    -- Short parameter description.  See the below note.

    description = "",
    -- General description of the command's purpose.

    privs = {debug = true},
    -- Required privileges to run. See `core.check_player_privs()` for
    -- the format and see [Privileges] for an overview of privileges.

    func = function(name)
    propsystem.make_player_normal(core.get_player_by_name(name))
	end
	})
