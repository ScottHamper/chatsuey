local _G = getfenv();
local hooks = _G.ChatSuey.HookTable:new();

local hideButton = function (button)
    button:Hide();

    -- Scroll buttons are shown every time the active chat
    -- tab changes, among other scenarios.
    hooks:RegisterScript(button, "OnShow", function ()
        hooks[this].OnShow(this);
        this:Hide();
    end);
end;

hideButton(_G.ChatFrameMenuButton);
for i = 1, _G.NUM_CHAT_WINDOWS do
    local frameName = "ChatFrame" .. i;
    hideButton(_G[frameName .. "UpButton"]);
    hideButton( _G[frameName .. "DownButton"]);
    hideButton( _G[frameName .. "BottomButton"]);

    -- By hiding the "BottomButton", we lose a flashing indicator
    -- when the chat frame is not scrolled all the way down.
    -- That sucks.
    -- So we add our own indicator and reuse Blizzard's original
    -- flash implementation by overriding the "BottomButtonFlash"
    -- global variable with our new frame.
    -- Prob not the safest approach, but very effective.
    local flash = _G.CreateFrame(
        "Frame",
        frameName .. "ChatSueyBottomFlash",
        _G[frameName],
        "ChatSueyBottomFlashTemplate");

    _G[frameName .. "BottomButtonFlash"] = flash;
end