local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
ChatSuey.Timestamps = ChatSuey.Timestamps or {};

-- All of this stuff will likely be moved out into the core ChatSuey addon
-- once another addon that needs to have configurable chat frame settings
-- is created.

-- Blizzard's UI code doesn't let us insert buttons at specific indices in a
-- drop down menu. So in order to make this a possibility, we cache the `info`
-- object passed into `AddButton`. Later, we can easily work with our cache to
-- overwrite/re-add buttons in the order we want.
local buttonInfo = {};

local uiDropDownMenu_AddButton = function (info, level)
    level = level or 1;

    local dropDown = _G["DropDownList" .. level];
    local index = dropDown.numButtons + 1;

    buttonInfo[level] = buttonInfo[level] or {};
    buttonInfo[level][index] = info;

    hooks[_G].UIDropDownMenu_AddButton(info, level);
end;

hooks:RegisterFunc(_G, "UIDropDownMenu_AddButton", uiDropDownMenu_AddButton);

-- The default `Initialize` hides all buttons and sets `numButtons` back to 0,
-- so we'll also use the opportunity to reset our `buttonInfo` cache.
local uiDropDownMenu_Initialize = function (frame, initFunction, displayMode, level)
    buttonInfo = {};
    hooks[_G].UIDropDownMenu_Initialize(frame, initFunction, displayMode, level);
end;

hooks:RegisterFunc(_G, "UIDropDownMenu_Initialize", uiDropDownMenu_Initialize);

ChatSuey.Timestamps.UIDropDownMenu_AddButton = function (info, level, index)
    level = level or 1;
    local dropDown = _G["DropDownList" .. level];
    local buttonCount = dropDown.numButtons;

    if not index or index > buttonCount then
        _G.UIDropDownMenu_AddButton(info, level);
        return;
    end

    if index < 1 then
        error("Index must be greater than 0; Invalid index: " .. index);
    end

    for i = buttonCount, index, -1 do
        buttonInfo[level][i + 1] = buttonInfo[level][i];
    end

    buttonInfo[level][index] = info;

    -- The default UI code uses `numButtons` to determine which button global
    -- variable should have attributes set on it when the next button is added.
    -- By resetting this, we effectively cause all buttons at, and after, the
    -- specified index to be overwritten.
    dropDown.numButtons = index - 1;

    for i = index, buttonCount + 1 do
        local buttonInfo = buttonInfo[level][i];
        _G.UIDropDownMenu_AddButton(buttonInfo, level);
    end
end;