/*
    This file is called when the server loads the gamemode. 
    The example below tells the resource system to send the two files to the client, 
    and then loads shared.lua.
*/

AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_thirdperson.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

/*
    For some reason models in this format:
    "models/Kleiner.mdl"
    Do not contain animations, and must include player directory:
    "models/player/kleiner.mdl"
    For fucks sake that was a hassle to figure out
*/
local modelList = {
    "models/player/kleiner.mdl",
    "models/player/mossman.mdl",
    "models/player/player/alyx.mdl",
    "models/player/barney.mdl",
    "models/player/eli.mdl",
    "models/player/gman_high.mdl",
    "models/player/monk.mdl",
    "models/player/odessa.mdl"
}

-- The hook that handles setting models to the player
function GM:PlayerSetModel(ply)
    local randomNum = math.random(1, #modelList)
    local model = modelList[randomNum]
    print("Current Model: " .. ply:GetModel() .. "\nSetting player model to: " .. model)
    ply:SetModel(model)
end

hook.Add('PlayerDeath', 'B_PlayerDeath', function(ply, infl, atckr)
    PrintMessage(HUD_PRINTTALK, ply:Name() .. " has died")
end)

-- Changes player skin on join, randomly chooses from modelList
hook.Add("PlayerInitialSpawn", "B_InitialChangeSkin", function(ply, trans)
    hook.Call("PlayerSetModel")
end)

-- Changes skin on spawn
hook.Add("PlayerSpawn", "B_ChangeSkin", function(ply, trans)
    hook.Call("PlayerSetModel")
end)