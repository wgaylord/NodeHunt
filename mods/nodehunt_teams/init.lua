
teams = {}


-- Teams have the following parameters 
--   Name - Displayer Name
--   Visable - If the player is visable when on this team
--   HasFly - If the player can fly when on this team
--   CanTakeDamage - If the player can take damage when on this team

teams.registered_teams = {spectator = {Name = "Spectators",Visable = true,HasFly = true, CanTakeDamage = false}}

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

function teams.set_player_team(player)
	local player_meta = player:get_meta()
	local player_team = player_meta:get("team")
	if player_team == nil then
		player_meta:set_string("team","spectator")
		return teams.registered_teams.spectator
	end
	local team = teams.registered_teams[player_team]
	if team == nil then
		player_meta:set_string("team","spectator")
		return teams.registered_teams.spectator
	end
	return teams.registered_teams[team]
end