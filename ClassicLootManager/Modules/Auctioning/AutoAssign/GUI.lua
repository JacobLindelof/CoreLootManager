-- ------------------------------- --
local  _, CLM = ...
-- ------ CLM common cache ------- --
local LOG       = CLM.LOG
local CONSTANTS = CLM.CONSTANTS
local UTILS     = CLM.UTILS
-- ------------------------------- --

-- Libs
local ScrollingTable = LibStub("ScrollingTable")
local AceGUI = LibStub("AceGUI-3.0")

local RightClickMenu

local function InitializeDB(self)
    self.db = CLM.MODULES.Database:GUI('tradeList', {
        location = {nil, nil, "CENTER", 0, 0 }
    })
end

local function StoreLocation(self)
    self.db.location = { self.top:GetPoint() }
end

local function RestoreLocation(self)
    if self.db.location then
        self.top:ClearAllPoints()
        self.top:SetPoint(self.db.location[3], self.db.location[4], self.db.location[5])
    end
end

local function ST_GetItemId(row)
    return row.cols[2].value
end

local function ST_GetAuctionBids(row)
    return row.cols[3].value
end

local function ST_GetAuctionTime(row)
    return row.cols[4].value
end

local function ST_GetItemSeq(row)
    return row.cols[5].value
end

local function ST_GetBidNames(row)
    return row.cols[6].value
end

local function ST_GetRolls(row)
    return row.cols[7].value
end

local TradeListGUI = {}
function TradeListGUI:Initialize()
    LOG:Trace("TradeListGUI:Initialize()")
    if not CLM.MODULES.ACL:IsTrusted() then return end
    InitializeDB(self)

    self.tooltip = GameTooltip
    RightClickMenu = CLM.UTILS.GenerateDropDownMenu(
        {
            {
                title = CLM.L["Open trade"],
                func = (function()
                    -- local rowData = self.st:GetRow(self.st:GetSelection())
                    -- if not rowData or not rowData.cols then return end
                    -- CLM.MODULES.AuctionHistoryManager:Remove(ST_GetItemSeq(rowData))
                end),
                color = "0000cc"
            },
            {
                separator = true,
                trustedOnly = true,
            },
            {
                title = CLM.L["Remove"],
                func = (function()
                    -- local rowData = self.st:GetRow(self.st:GetSelection())
                    -- if not rowData or not rowData.cols then return end
                    -- CLM.MODULES.AuctionHistoryManager:Remove(ST_GetItemSeq(rowData))
                end),
                color = "cc0000"
            },
            {
                separator = true,
                trustedOnly = true,
            },
            {
                title = CLM.L["Remove all"],
                func = (function()
                    -- CLM.MODULES.AuctionHistoryManager:Wipe()
                end),
                color = "cc0000"
            }
        },
        CLM.MODULES.ACL:CheckLevel(CONSTANTS.ACL.LEVEL.ASSISTANT),
        CLM.MODULES.ACL:CheckLevel(CLM.CONSTANTS.ACL.LEVEL.MANAGER)
    )

    self:Create()
    CLM.MODULES.EventManager:RegisterWoWEvent({"PLAYER_LOGOUT"}, (function() StoreLocation(self) end))
    self:RegisterSlash()
    self._initialized = true
    self:Refresh()
end

local ROW_HEIGHT = 18
local MIN_HEIGHT = 105

local function CreateAuctionDisplay(self)
    local columns = {
        {name = "", width = 200},
        {name = "", width = 95,
            comparesort = UTILS.LibStCompareSortWrapper(UTILS.LibStModifierFn)
        }
    }
    local TradeHistoryGroup = AceGUI:Create("SimpleGroup")
    TradeHistoryGroup:SetLayout("Flow")
    TradeHistoryGroup:SetWidth(265 + 95)
    TradeHistoryGroup:SetHeight(MIN_HEIGHT)
    self.TradeHistoryGroup = TradeHistoryGroup
    -- Standings
    self.st = ScrollingTable:CreateST(columns, 1, ROW_HEIGHT, nil, TradeHistoryGroup.frame)
    self.st:EnableSelection(true)
    self.st.frame:SetPoint("TOPLEFT", TradeHistoryGroup.frame, "TOPLEFT", 0, 0)
    self.st.frame:SetBackdropColor(0.1, 0.1, 0.1, 0.1)
    self.st:SetData({})
    -- fix weird behavior when scaling down list and scrollbar not hiding
    self.st.scrollframe:SetScript("OnHide", function() end)
    -- OnEnter handler -> on hover
    local OnEnterHandler = (function (rowFrame, cellFrame, data, cols, row, realrow, column, table, ...)
        local status = self.st.DefaultEvents["OnEnter"](rowFrame, cellFrame, data, cols, row, realrow, column, table, ...)
        -- local rowData = self.st:GetRow(realrow)
        -- if not rowData or not rowData.cols then return status end
        -- local tooltip = self.tooltip
        -- if not tooltip then return end
        -- local itemId = ST_GetItemId(rowData)
        -- local itemString = "item:" .. tonumber(itemId)
        -- tooltip:SetOwner(rowFrame, "ANCHOR_TOPRIGHT")
        -- tooltip:SetHyperlink(itemString)
        -- tooltip:AddLine(ST_GetAuctionTime(rowData))
        -- local bidNames = ST_GetBidNames(rowData) or {}
        -- local rolls = ST_GetRolls(rowData) or {}
        -- local noBids = true
        -- for bidder, bid in pairs(ST_GetAuctionBids(rowData)) do
        --     noBids = false
        --     bid  = tostring(bid)
        --     if rolls[bidder] then
        --         bid  = bid .. "/" .. tostring(rolls[bidder])
        --     end
        --     if bidNames[bidder] then
        --         bid = bid .. " (" .. bidNames[bidder] .. ")"
        --     end
        --     local bidderProfile = CLM.MODULES.ProfileManager:GetProfileByName(bidder)
        --     if bidderProfile then
        --         bidder = UTILS.ColorCodeText(bidder, UTILS.GetClassColor(bidderProfile:Class()).hex)
        --     end
        --     tooltip:AddDoubleLine(bidder, bid)
        -- end
        -- if noBids then
        --     tooltip:AddLine(CLM.L["No bids"])
        -- end
        -- tooltip:Show()
        return status
    end)
    -- OnLeave handler -> on hover out
    local OnLeaveHandler = (function (rowFrame, cellFrame, data, cols, row, realrow, column, table, ...)
        local status = self.st.DefaultEvents["OnLeave"](rowFrame, cellFrame, data, cols, row, realrow, column, table, ...)
        self.tooltip:Hide()
        return status
    end)
    -- end
    -- OnClick handler
    local OnClickHandler = function(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
        local rightButton = (button == "RightButton")
        local status
        local selected = self.st:GetSelection()
        if selected ~= realrow then
            if (row or realrow) then -- disables sorting click
                status = self.st.DefaultEvents["OnClick"](rowFrame, cellFrame, data, cols, row, realrow, column, table, rightButton and "LeftButton" or button, ...)
            end
        end
        if rightButton then
            UTILS.LibDD:CloseDropDownMenus()
            UTILS.LibDD:ToggleDropDownMenu(1, nil, RightClickMenu, cellFrame, -20, 0)
        elseif IsModifiedClick() then
            local rowData = table:GetRow(realrow)
            if rowData and rowData.cols then
                -- local message = (ST_GetInfo(rowData) or "") .. " - " .. (ST_GetValue(rowData) or "") .. " - " .. (ST_GetDate(rowData) or "") .. " - " .. (ST_GetPlayer(rowData) or "")
                HandleModifiedItemClick(message)
            end
        end
        return status
    end
    -- end

    self.st:RegisterEvents({
        OnEnter = OnEnterHandler,
        OnLeave = OnLeaveHandler,
        OnClick = OnClickHandler
    })

    return TradeHistoryGroup
end

function TradeListGUI:Create()
    LOG:Trace("TradeListGUI:Create()")
    -- Main Frame
    local f = AceGUI:Create("Frame")
    f:SetTitle(CLM.L["Trade List"])
    f:SetStatusText("")
    f:SetLayout("Table")
    f:SetUserData("table", { columns = {0, 0}, alignV =  "top" })
    f:EnableResize(false)
    f:SetWidth(265)
    f:SetHeight(MIN_HEIGHT)
    self.top = f

    f:AddChild(CreateAuctionDisplay(self))
    RestoreLocation(self)
    -- Hide by default
    f:Hide()

end

function TradeListGUI:Refresh(visible)
    LOG:Trace("TradeListGUI:Refresh()")
    if not self._initialized then return end
    if visible and not self.top:IsVisible() then return end

    local data = {}
    local stack = CLM.MODULES.AuctionHistoryManager:GetHistory()
    -- Data
    local rowId = 1
    for seq, auction in ipairs(stack) do
        local row = {
            cols = {
                { value = auction.link},
                { value = auction.id },
                { value = auction.bids },
                { value = date(CLM.L["%Y/%m/%d %a %H:%M:%S"], auction.time) },
                { value = seq },
                { value = auction.names },
                { value = auction.rolls }
            }
        }
        data[rowId] = row
        rowId = rowId + 1
    end
    -- View
    local rows = (#stack < 20) and #stack or 20
    local previousRows = self.previousRows or rows
    local rowDiff = rows - previousRows
    self.previousRows = rows

    local height = MIN_HEIGHT + ROW_HEIGHT*(rows-1)
    if height < MIN_HEIGHT then height = MIN_HEIGHT end
---@diagnostic disable-next-line: missing-parameter
    local _, _, point, x, y = self.top:GetPoint()
    self.top:SetHeight(height)
    self.TradeHistoryGroup:SetHeight(height)
    self.st:SetDisplayRows((rows == 0) and 1 or rows, ROW_HEIGHT)

    -- Makes it grow down / shorten up instead of omnidirectional
    if (rows == 0 and previousRows == 1) then -- Removed last one
        -- do nothing
    elseif (rows == 0 and previousRows > 0) then -- Removed all
        self.top:SetPoint(point, x, y + ((-rowDiff - 1)*ROW_HEIGHT/2))
    elseif (rows == 1 and previousRows == 0) then -- Added first
        -- do nothing
    else
        if (rowDiff > 0) then
            self.top:SetPoint(point, x, y - (rowDiff*ROW_HEIGHT/2))
        elseif (rowDiff < 0) then
            self.top:SetPoint(point, x, y + (-rowDiff*ROW_HEIGHT/2))
        end
    end
    self.st:SetData(data)
end

function TradeListGUI:Toggle()
    LOG:Trace("TradeListGUI:Toggle()")
    if not self._initialized then return end
    if self.top:IsVisible() then
        self.top:Hide()
    else
        self:Refresh()
        self.top:Show()
    end
end

function TradeListGUI:RegisterSlash()
    local options = {
        trade = {
            type = "execute",
            name = "Trade List",
            desc = CLM.L["Toggle Trade List window display"],
            handler = self,
            func = "Toggle",
        }
    }
    CLM.MODULES.ConfigManager:RegisterSlash(options)
end

function TradeListGUI:Reset()
    LOG:Trace("TradeListGUI:Reset()")
    self.top:ClearAllPoints()
    self.top:SetPoint("CENTER", 0, 0)
end

CLM.GUI.TradeList = TradeListGUI