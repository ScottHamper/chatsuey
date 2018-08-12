local hooks = _G.ChatSuey.HookTable:new();

local CHAT_FRAME_MARGIN = 2;

local hide = function (frame)
    frame:Hide();

    -- Makes sure that the frame can never be shown again in the future.
    hooks:RegisterScript(frame, "OnShow", function (self)
        hooks[self].OnShow();
        self:Hide();
    end);
end;

hide(_G.QuickJoinToastButton);
hide(_G.ChatFrameMenuButton);
hide(_G.ChatFrameChannelButton);

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
    local _, _, _, leftOffset = chatFrame.Background:GetPoint(1); -- TOPLEFT
    local _, _, _, rightOffset = chatFrame.Background:GetPoint(2); -- TOPRIGHT
    local left = leftOffset - CHAT_FRAME_MARGIN;
    local right = rightOffset + CHAT_FRAME_MARGIN;
    local top = _G[frameName .. "Tab"]:GetHeight();
    local bottom = -_G[frameName .. "EditBox"]:GetHeight() - CHAT_FRAME_MARGIN;

    chatFrame:SetClampRectInsets(left, right, top, bottom);

    -- Now that we've updated the ClampRectInsets, we don't ever want the
    -- Blizzard UI to reset them back to default values. This was mainly
    -- an issue with ChatFrame2 (the combat log).
    hooks:RegisterFunc(chatFrame, "SetClampRectInsets", function () end);

    -- Starting in 8.0, newly created temporary chat frames (e.g., whisper frames)
    -- cannot be positioned outside of their ClampRectInsets. As a result, we need
    -- to reanchor the frame now that we've updated its ClampRectInsets, in case the
    -- primary frame of the GENERAL_CHAT_DOCK is positioned outside the default insets.
    local dock = _G.GENERAL_CHAT_DOCK;
    if chatFrame.isDocked and chatFrame ~= dock.primary then
        chatFrame:SetAllPoints(dock.primary);
    end
end);
