local _G = getfenv();
local X_OFFSET = 0;
local Y_OFFSET = 1;

_G.ChatFrameEditBox:ClearAllPoints();
_G.ChatFrameEditBox:SetPoint("BOTTOMLEFT", _G.DEFAULT_CHAT_FRAME, "TOPLEFT", X_OFFSET, Y_OFFSET);
_G.ChatFrameEditBox:SetPoint("BOTTOMRIGHT", _G.DEFAULT_CHAT_FRAME, "TOPRIGHT", X_OFFSET, Y_OFFSET);