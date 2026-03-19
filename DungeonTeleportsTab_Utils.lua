DungeonTeleportsTab_Utils = DungeonTeleportsTab_Utils or {}

function DungeonTeleportsTab_Utils.IsVersionAtLeast(current, required)
    local c1, c2, c3 = tostring(current or ""):match("(%d+)%.?(%d*)%.?(%d*)")
    local r1, r2, r3 = tostring(required or ""):match("(%d+)%.?(%d*)%.?(%d*)")
    c1, c2, c3 = tonumber(c1) or 0, tonumber(c2) or 0, tonumber(c3) or 0
    r1, r2, r3 = tonumber(r1) or 0, tonumber(r2) or 0, tonumber(r3) or 0
    if c1 ~= r1 then return c1 > r1 end
    if c2 ~= r2 then return c2 > r2 end
    return c3 >= r3
end

function DungeonTeleportsTab_Utils.IsAddOnLoaded(addonName)
    if not addonName or addonName == "" then
        return false
    end

    if C_AddOns and C_AddOns.IsAddOnLoaded then
        return C_AddOns.IsAddOnLoaded(addonName)
    end

    if _G.IsAddOnLoaded then
        return _G.IsAddOnLoaded(addonName)
    end

    return false
end

function DungeonTeleportsTab_Utils.IsAddOnEnabled(addonName)
    if not addonName or addonName == "" then
        return false
    end

    local characterName = UnitName and UnitName("player")

    if C_AddOns and C_AddOns.GetAddOnEnableState then
        local enableState = C_AddOns.GetAddOnEnableState(characterName, addonName)
        return enableState and enableState > 0 or false
    end

    if _G.GetAddOnEnableState then
        local enableState = _G.GetAddOnEnableState(characterName, addonName)
        return enableState and enableState > 0 or false
    end

    return false
end

function DungeonTeleportsTab_Utils.IsAddOnActive(addonName)
    return DungeonTeleportsTab_Utils.IsAddOnLoaded(addonName)
        or DungeonTeleportsTab_Utils.IsAddOnEnabled(addonName)
end

function DungeonTeleportsTab_Utils.GetAddOnVersion(addonName)
    if not addonName or addonName == "" then
        return nil
    end

    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(addonName, "Version")
    end

    if _G.GetAddOnMetadata then
        return _G.GetAddOnMetadata(addonName, "Version")
    end

    return nil
end