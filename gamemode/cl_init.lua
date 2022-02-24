/*
    This file is called when the client loads the gamemode. 
    You would put client specific things in here. We load shared.lua. 
    Note that you can only 'include' files here that have been 'AddCSLuaFile'd on the server.

    Declared naming conventions:
    variables will be multiword delimited (ex. variable_name)
    variables will be in camelCase
    function names will be in PascalCase
*/

include("shared.lua")
include("cl_hud.lua")
include("cl_thirdperson.lua")

local canSeeThrough = false

-- Hook example from wiki, draws players through walls
hook.Add( "HUDPaint", "3d_camera_example", function()
    if canSeeThrough then
        cam.Start3D()
		for id, ply in ipairs( player.GetAll() ) do
			ply:DrawModel()
		end
	    cam.End3D()
    end
end )

local function B_PlayerMenu()
    local scrW, scrH = ScrW(), ScrH()
    local menuWidth, menuHeight = 700, 500
    local buttonMinX, buttonMinY = 10, 30
    // Main Menu
    local b_menuframe = vgui.Create("DFrame")
    --  Put menu in middle of screen, re-adjust for height and width because the origin of
    --  the menu is in the top left 
    b_menuframe:SetPos(scrW/2 - menuWidth/2, scrH/2 - menuHeight/2) 
    b_menuframe:SetSize(menuWidth, menuHeight) 
    b_menuframe:SetTitle("Barren Menu") 
    b_menuframe:SetVisible(true) 
    b_menuframe:SetDraggable(false) 
    b_menuframe:ShowCloseButton(true) 
    b_menuframe:MakePopup()

    // Button for toggling x-ray vision
    local b_button1 = vgui.Create("DButton", b_menuframe)
    b_button1:SetText("Player X-Ray")
    b_button1:SetPos(buttonMinX, buttonMinY)
    b_button1:SetSize(100, 30)
    b_button1.DoClick = function()
        if canSeeThrough then
            canSeeThrough = false 
        else
            canSeeThrough = true
        end
    end

    local b_button2 = vgui.Create("DButton", b_menuframe)
    b_button2:SetText("Another Button")
    b_button2:SetPos(buttonMinX, buttonMinY * 2)
    b_button2:SetSize(100, 30)
end

-- Our hook responsible for knowing when player press q, which will open the menu
hook.Add( "PlayerButtonDown", "B_ButtonMenuKey", function( ply, button )
	if CLIENT then
		-- if ( IsFirstTimePredicted() ) then print( ply:Nick() .. " pressed " .. input.GetKeyName( button ) ) end
        if (IsFirstTimePredicted() && input.GetKeyName(button) == "q") then
            print("==")
            print(ply:Nick() .. " has opened the player menu.")
            B_PlayerMenu()
            print("==")
        end
    end
end)

