local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local LS = ChatSuey.Timestamps.LOCALES[_G.GetLocale()].Strings;

local ROOT_OPTION = {
    text = LS["Timestamps"],
    hasArrow = true,
    notCheckable = true,
};

local use24HourClockOption = function (chatFrame)
    local config = ChatSuey.Timestamps.Config[chatFrame];

    return {
        text = LS["Use 24 hour clock"],
        checked = config.use24HourClock,
        keepShownOnClick = true,
        func = function ()
            -- This function runs before the checkbox has been toggled
            config.use24HourClock = not _G.UIDropDownMenuButton_GetChecked();
        end,
    };
end;

local includeSecondsOption = function (chatFrame)
    local config = ChatSuey.Timestamps.Config[chatFrame];

    return {
        text = LS["Include seconds"],
        checked = config.includeSeconds,
        keepShownOnClick = true,
        func = function ()
            config.includeSeconds = not _G.UIDropDownMenuButton_GetChecked();
        end,
    };
end;

local useConsistentColorOption = function (chatFrame)
    local config = ChatSuey.Timestamps.Config[chatFrame];
    local originalColor = config.color;

    return {
        text = LS["Use consistent color"],
        checked = config.useConsistentColor,
        keepShownOnClick = true,
        hasColorSwatch = true,
        r = config:r(),
        g = config:g(),
        b = config:b(),

        func = function ()
            config.useConsistentColor = not _G.UIDropDownMenuButton_GetChecked();
        end,

        swatchFunc = function ()
            local r, g, b = ColorPickerFrame:GetColorRGB();
            config.color = string.format("%.2x%.2x%.2x", r * 255, g * 255, b * 255);
        end,

        cancelFunc = function ()
            config.color = originalColor;
        end,
    };
end;

local findMenuButtonIndexByValue = function (frame, value)
    for i = 1, frame.numButtons do
        local button = _G[frame:GetName() .. "Button" .. i];

        if button.value == value then
            return i;
        end
    end
end;

local initialize = function (frame, level)
    hooks[frame].initialize(level);

    if _G.UIDROPDOWNMENU_MENU_LEVEL == 1 then
        local menu = _G["DropDownList1"];
        local displayIndex = findMenuButtonIndexByValue(menu, _G.DISPLAY);

        ChatSuey.Timestamps.UIDropDownMenu_AddButton(ROOT_OPTION, 1, displayIndex + 1);
        return;
    end

    if _G.UIDROPDOWNMENU_MENU_LEVEL == 2 and UIDROPDOWNMENU_MENU_VALUE == LS["Timestamps"] then
        local chatFrame = _G.FCF_GetCurrentChatFrame();

        _G.UIDropDownMenu_AddButton(use24HourClockOption(chatFrame), 2);
        _G.UIDropDownMenu_AddButton(includeSecondsOption(chatFrame), 2);
        _G.UIDropDownMenu_AddButton(useConsistentColorOption(chatFrame), 2);
    end
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local dropDown = _G["ChatFrame" .. i .. "TabDropDown"];

    hooks:RegisterFunc(dropDown, "initialize", function (level)
        initialize(dropDown, level);
    end);
end