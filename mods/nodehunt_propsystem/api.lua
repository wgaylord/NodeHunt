
propsystem = {}

-- Sets a players model and texture to the same as a node, currently only supports full node nodes
function propsystem.set_player_node(player,node)
	core.log(node)
	if propsystem.vaild_nodes[node] == nil then
		return false
	end
	 player_api.set_model(player,"node.obj")
	 player_api.set_textures(player,propsystem.vaild_nodes[node])
	 player:add_pos({x=0,y=1,z=0})
end


function propsystem.make_player_normal(player)
	player_api.set_model(player, "character.b3d")
	player_api.set_textures(player,{"character.png"})
end

function propsystem.make_player_invisable(player)
player_api.set_model(player, "invis")
end
