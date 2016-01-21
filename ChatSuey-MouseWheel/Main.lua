local hooks = _G.ChatSuey.HookTable:new();

local SCROLL_COUNT = 1;
local FAST_SCROLL_COUNT = 5;

local onMouseScroll = function(self, delta)
    if _G.IsControlKeyDown() then
        local scrollFull = delta > 0 and self.ScrollToTop or self.ScrollToBottom;

        scrollFull(self);
        return;
    end

    local scrollCount = _G.IsShiftKeyDown() and FAST_SCROLL_COUNT or SCROLL_COUNT;

    for i = 1, scrollCount do
        hooks[_G].FloatingChatFrame_OnMouseScroll(self, delta);
    end
end;

-- This function gets bound to each chat frame's "OnMouseWheel"
-- script after this addon is loaded/executed.
hooks:RegisterFunc(_G, "FloatingChatFrame_OnMouseScroll", onMouseScroll);