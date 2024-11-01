
teams = {}

-- Gets the players team from a player object
-- If the player is missing the team info OR on an invalid team, default them to spectator and return it.

function teams.get_player_team(player)
	local player_meta = player:get_meta()
	local player_team = player_meta:get("team")
	if player_team == nil then
		player_meta:set_string("team","spectator")
		return "spectator"
	end
	local team = teams.registered_teams[player_team]
	if team == nil then
		player_meta:set_string("team","spectator")
		return "spectator"
	end
	return player_team
end

function teams.get_team(team)
	return teams.registered_teams[team]
end


function teams.set_player_team(player,team)
	if teams.registered_teams[team] == nil then
		return false
	end
	local player_meta = player:get_meta()
	player_meta:set_string("team",team)
	teams.update_player_abilites(player)
	
	return true
end


function teams.register_team(team_id,team)
	if type(team_id) != "string" then
		return false
	end
	teams.registered_teams[team_id] = {Name = team.Name or "", Visable = team.Visable or true,CanTakeDamage = team.CanTakeDamage or true,Privileges = team.Privileges or {privs = false,fly = false, interact = true,shout = true,fast = false,noclip = false,teleport = false,creative = false,bring = false,give = false,settime = false,debug = false}}
	return true
end


function teams.update_player_abilites(player):
	local team = teams.registered_teams[teams.get_player_team(player)]
	if team then
		core.set_player_privs(player:get_player_name(),team.Privileges})
		if team.CanTakeDamage then
			player:set_armor_groups({})
		else
			player:set_armor_groups({group1 = 'imortal'})
		end
	end
end

