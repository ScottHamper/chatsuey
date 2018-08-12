local hooks = _G.ChatSuey.HookTable:new();

local CHAT_FRAME_MARGIN = 4;

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
    local left = -CHAT_FRAME_MARGIN;
    local right = CHAT_FRAME_MARGIN;
    local top = _G[frameName .. "Tab"]:GetHeight();
    local bottom = -_G[frameName .. "EditBox"]:GetHeight();

    chatFrame:SetClampRectInsets(left, right, top, bottom);
    
    -- Starting in 8.0, newly created temporary chat frames (e.g., whisper frames)
    -- cannot be positioned outside of their ClampRectInsets. As a result, we need
    -- to reanchor the frame now that we've updated its ClampRectInsets, in case the
    -- primary frame of the GENERAL_CHAT_DOCK is positioned outside the default insets.
    local dock = _G.GENERAL_CHAT_DOCK;
    if chatFrame.isDocked and chatFrame ~= dock.primary then
        chatFrame:SetAllPoints(dock.primary);
    end
end);
