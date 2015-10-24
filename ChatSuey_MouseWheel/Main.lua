local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local MOUSE_WHEEL_UP = 1;
local MOUSE_WHEEL_DOWN = -1;

-- ENHANCEMENT: Allow these to be configurable in-game
local SCROLL_COUNT = 1;
local FAST_SCROLL_COUNT = 5;

local onMouseWheel = function()
    local direction = _G.arg1;
    local scrollOnce = direction == MOUSE_WHEEL_UP and this.ScrollUp or this.ScrollDown;
    local scrollFull = direction == MOUSE_WHEEL_UP and this.ScrollToTop or this.ScrollToBottom;

    hooks[this].OnMouseWheel(this, direction);

    if _G.IsControlKeyDown() then
        scrollFull(this);
        return;
    end

    local scrollCount = _G.IsShiftKeyDown() and FAST_SCROLL_COUNT or SCROLL_COUNT;

    for i = 1, scrollCount do
        scrollOnce(this);
    end
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnMouseWheel", onMouseWheel);
    chatFrame:EnableMouseWheel(true);
end