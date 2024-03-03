-- ------------------------------- --
local  _, CLM = ...
-- ------ CLM common cache ------- --
local LOG       = CLM.LOG
-- local CONSTANTS = CLM.CONSTANTS
-- local UTILS     = CLM.UTILS
-- ------------------------------- --

local GlobalGuildChangeHandler = {
    changeDetected = false
}
function GlobalGuildChangeHandler:Initialize()
    CLM.MODULES.EventManager:RegisterWoWEvent({"PLAYER_GUILD_UPDATE"}, function(_, _, unitTarget)
        if unitTarget ~= "player" then return end
        if GlobalGuildChangeHandler.changeDetected then return end -- Change alredy detected
        LOG:Message(CLM.L["Guild change detected. Disabling synchronisation until UI reload."])
        CLM.MODULES.LedgerManager:Cutoff()
        CLM.MODULES.LedgerManager:DisableAdvertising()
        CLM.MODULES.Database:ForceFallback()
        CLM.MODULES.GuildInfoListener:WipeAll()
        CLM.MODULES.Minimap:UpdateIcon()
        GlobalGuildChangeHandler.changeDetected = true
    end)
end
CLM.GlobalGuildChangeHandler = GlobalGuildChangeHandler
