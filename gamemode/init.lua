/*
    This file is called when the server loads the gamemode. 
    The example below tells the resource system to send the two files to the client, 
    and then loads shared.lua.
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )