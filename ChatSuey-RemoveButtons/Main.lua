local hooks = _G.ChatSuey.HookTable:new();

local CHAT_FRAME_MARGIN = 4;

local hide = function (frame)
    frame:Hide();

    -- Makes sure that things can never be shown in the future.
    -- For example, the "MenuButton" normally re-shows when
    -- changing the active chat tab.
    hooks:RegisterScript(frame, "OnShow", function ()
        hooks[this].OnShow();
        this:Hide();
    end);
end;

hide(_G.FriendsMicroButton);
hide(_G.ChatFrameMenuButton);

for i = 1, _G.NUM_CHAT_WINDOWS do
    local frameName = "ChatFrame" .. i;
    local chatFrame = _G[frameName];
    local buttonFrame = _G[frameName .. "ButtonFrame"];

    hide(buttonFrame);

    -- Now that the button frame is gone, we want to allow the
    -- chat frame to move closer to the edge of the screen.
    -- While we're at it, we'll let it move more vertically, too.
    local left = -CHAT_FRAME_MARGIN;
    local right = CHAT_FRAME_MARGIN;
    local top = _G[frameName .. "Tab"]:GetHeight();
    local bottom = -_G[frameName .. "EditBox"]:GetHeight();

    chatFrame:SetClampRectInsets(left, right, top, bottom);

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
        chatFrame,
        "ChatSueyBottomFlashTemplate");

    _G[frameName .. "ButtonFrameBottomButtonFlash"] = flash;
end