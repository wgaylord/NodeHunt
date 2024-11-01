
dofile(core.get_modpath("nodehunt_propsystem") .. "/api.lua")


propsystem.vaild_nodes = {}

-- Get all valid nodes that players can hide as, this is to support mods that add extra nodes aside for our basic nodes.
-- For now this is nodes that fully fill the node

core.register_on_mods_loaded(function()
	for nodeName, node in pairs(core.registered_nodes) do
			if node.drawtype == "normal" or node.drawtype == "glasslike"  or node.drawtype == "glasslike_framed"  or node.drawtype == "glasslike_framed_optional" or node.drawtype == "allfaces"  or node.drawtype == "allfaces_optional" then 
				propsystem.vaild_nodes[nodeName] = node.tiles
			end
	end
end)

--Model for full nodes
player_api.register_model("node.obj", {
	textures = {},
	animations = {},
	visual_size = {x = 1, y = 1, z = 1},
	collisionbox = {-0.48,-0.5,-0.48,0.48,0.48,0.48},
	stepheight = 0.6,
	eye_height = 0.5,
})


--Junk model to make the player invisable
player_api.register_model("invis", {
	textures = {},
	animations = {},
	visual_size = {x = 1, y = 1, z = 1},
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	stepheight = 0.6,
	eye_height = 1.47,
})
