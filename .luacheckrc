---@diagnostic disable: lowercase-global
-- File is licensed on CC Share-Alike license by https://github.com/DeadlyBossMods and is taken from that repository
std = "lua51"
max_line_length = false

exclude_files = {
	"**/Libs/**",
	"**/.git/**",
	"**/.vscode/**",
	"**/scripts/**"
}
ignore = {
	"11./SLASH_.*", -- Setting an undefined (Slash handler) global variable
	"11./BINDING_.*", -- Setting an undefined (Keybinding header) global variable
	"113/Enum*",
	"211/CLM",
	"212", -- Unused argument
	"542", -- An empty if branch
}
globals = {
	-- Design
	"CLM",
	"LibStub",
	-- Saved Variable
	"CLM_DB",
	"CLM_Logs",
	"CLM_MinimapIcon",
	-- 
	"CLM2_DB",
	"CLM2_Logs",
	"CLM2_MinimapIcon",
	"CLM_UnifiedGUI_Toggle",
	-- Bindings
	"CLM_Undo",
	"CLM_Redo",
	-- Monolith and Essential and Community
	"MonDKP_DKPTable",
	"MonDKP_Loot",
	"CommDKP_DKPTable",
	"CommDKP_Loot",
	"CommDKP_DB",
	-- RCLC
	"RCLootCouncil",
	-- VDT 
	"DevTool",
	"DevTool_AddData",
	-- ElvUI
	"ElvUI",
	-- WoW
	"Ambiguate",
	"RaidWarningFrame",
	"RaidWarningFrame_OnEvent",
	"C_Seasons.GetActiveSeason",
	"ERR_CHAT_PLAYER_NOT_FOUND_S",
	"LOOT_ITEM_SELF_MULTIPLE",
	"LOOT_ITEM_SELF",
	"LE_ITEM_CLASS_RECIPE",
	"LE_ITEM_CLASS_QUESTITEM",
	"LOOT_ROLL_TYPE_PASS",
	"LOOT_ROLL_TYPE_NEED",
	"LOOT_ROLL_TYPE_GREED",
	"LOOT_ROLL_TYPE_DISENCHANT",
	"ROLL_DISENCHANT",
	"TRANSMOGRIFICATION",
	"GREED",
	"NEED",
	"PASS",
	"GetLootRollItemInfo",
	"GetLootRollItemLink",
	"RollOnLoot",
	"ConfirmLootRoll",
	"StaticPopup_Hide",
	"CreateFromMixins",
	"ItemMixin",
	"_G",
	"Item",
	"MAX_RAID_MEMBERS",
	"LootAlertSystem",
	"KeyBindingFrame_LoadUI",
	"KeyBindingFrame",
	"InterfaceOptionsFrame",
	"PlaySound",
	"SOUNDKIT",
	"AlertFrame",
	"strsplit",
	"strlen",
	"strlower",
	"GetItemInfo",
	"GetItemInfoInstant",
	"GetAddOnInfo",
	"tinsert",
	"tremove",
	"date",
	"time",
	"wipe",
	"strsub",
	"GetServerTime",
	"C_Timer.After",
	"C_Timer.NewTicker", 
	"GetNumGuildMembers",
	"GetGuildRosterInfo",
	"GetTime",
	"IsAddOnLoaded",
	"GetRealmName",
	"UnitFactionGroup",
	"UnitName",
	"GetGuildInfo",
	"C_GuildInfo.GuildRoster",
	"hooksecurefunc",
	"MasterLooterFrame",
	"SetGuildRosterShowOffline",
	"IsInGuild",
	"GetLocale",
	"GuildRoster",
	"InterfaceOptionsFrame_OpenToCategory",
	"SendChatMessage",
	"GameTooltip",
	"GetItemClassInfo",
	"IsInRaid",
	"UnitGUID",
	"GetNumLootItems",
	"GetLootSlotInfo",
	"GetLootSlotLink",
	"BIND_TRADE_TIME_REMAINING",
	"ITEM_SOULBOUND",
	"CreateFrame",
	"UIParent",
	"C_Container.GetContainerItemInfo",
	"C_Container.GetContainerNumSlots",
	"C_Container.UseContainerItem",
	"GetTradePlayerItemLink",
	"ERR_TRADE_COMPLETE",
	"GetNumGroupMembers",
	"GetMasterLootCandidate",
	"GiveMasterLoot",
	"IsControlKeyDown",
	"INVSLOT_HEAD",
	"INVSLOT_NECK",
	"INVSLOT_SHOULDER",
	"INVSLOT_BODY",
	"INVSLOT_CHEST",
	"INVSLOT_WAIST",
	"INVSLOT_LEGS",
	"INVSLOT_FEET",
	"INVSLOT_WRIST",
	"INVSLOT_HAND",
	"INVSLOT_FINGER1",
	"INVSLOT_FINGER2",
	"INVSLOT_TRINKET1",
	"INVSLOT_TRINKET2",
	"INVSLOT_MAINHAND",
	"INVSLOT_OFFHAND",
	"INVSLOT_RANGED",
	"INVSLOT_BACK",
	"INVSLOT_TABARD",
	"INVSLOT_CHEST",
	"GetInventoryItemID",
	"InCombatLockdown",
	"IsGuildLeader",
	"GuildControlGetNumRanks",
	"C_GuildInfo.GuildControlGetRankFlags",
	"GetNormalizedRealmName",
	"IsAltKeyDown",
	"IsShiftKeyDown",
	"ChatFrame_AddMessageEventFilter",
	"HideUIPanel",
	"ShowUIPanel",
	"GetRaidRosterInfo",
	"tDeleteItem",
	"CreateObjectPool",
	"IsModifiedClick",
	"HandleModifiedItemClick",
	"StaticPopupDialogs",
	"GetInstanceInfo",
	"StaticPopup_Show",
	"CombatLogGetCurrentEventInfo",
	"GetInstanceInfo",
	"UnitIsPlayer",
	"UnitClass",
	"UnitInBattleground",
	"IsActiveBattlefieldArena",
	"GetLootMethod",
	"ItemRefTooltip",
	"GetUnitName",
	"UISpecialFrames",
	"GetTalentGroupRole",
	"GetActiveTalentGroup",
	"CLASS_ICON_TCOORDS",
	"TradeFrame",
	"InitiateTrade",
	"Mixin",
	"PlaySoundFile",
	"IsInInstance",
	"ReloadUI",
	"GetBuildInfo",
	"UnitFullName",
	-- Retail only
	"EJ_GetEncounterInfo",
	"GetSpecialization",
	"GetSpecializationInfo",
	"EJ_GetInstanceInfo",
	"TooltipDataProcessor",
	"TooltipUtil",
	-- Classic Era only
	"GetContainerItemInfo",
	"GetContainerNumSlots",
	"UseContainerItem"
}