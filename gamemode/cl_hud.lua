-- Provides the HUD elements to hide
local hide = {
    CHudHealth = true,
    CHudBattery = true,
    CHudZoom = true,
    CHudWeaponSelection = true,
}

-- Hides HL2 HUD elements
hook.Add("HUDShouldDraw", "HideHUD", function(name)
    if hide[name] then return false end
end)
