
dofile(core.get_modpath("nodehunt_teams") .. "/api.lua")

-- Teams have the following parameters 
--   Name - Displayer Name
--   Visable - If the player is visable when on this team
--   HasFly - If the player can fly when on this team
--   CanTakeDamage - If the player can take damage when on this team

teams.registered_teams = {spectator = {Name = "Spectators",Visable = true,Privileges = {privs = false,fly = true, interact = false,shout = true,fast = true,noclip = false,teleport = false,creative = false,bring = false,give = false,settime = false,debug = false}}}
