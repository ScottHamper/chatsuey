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

hide(_G.QuickJoinToastButton);
hide(_G.ChatFrameMenuButton);

-- Battle.net toasts are anchored flush with the edge of the chat frame's
-- buttons by default. Since we've removed the buttons, we want toasts to
-- be flush with the chat frame instead.
hooks:RegisterFunc(_G, "BNToastFrame_UpdateAnchor", function (forceAnchor)
    local chatFrame = _G.DEFAULT_CHAT_FRAME;
    local originalButtonFrame = chatFrame.buttonFrame;

    -- Instead of re-implementing the entirety of Blizzard's
    -- BNToastFrame_UpdateAnchor just to change a line or two,
    -- we'll temporarily change the `buttonFrame` reference
    -- to the chatFrame itself.
    chatFrame.buttonFrame = chatFrame;

    hooks[_G].BNToastFrame_UpdateAnchor(forceAnchor);

    chatFrame.buttonFrame = originalButtonFrame;
end);

ChatSuey.OnChatFrameReady(function (chatFrame)
    local frameName = chatFrame:GetName();
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
end);