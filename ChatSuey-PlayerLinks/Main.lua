local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local DEFAULT_COLOR = ChatSuey.Colors.WHITE;

local onHyperlinkClick = function ()
    local uri = _G.arg1;
    local link = _G.arg2;
    local scheme, player, text, color = ChatSuey.HyperlinkComponents(link);

    if scheme ~= ChatSuey.UriSchemes.PLAYER then
        hooks[this].OnHyperlinkClick();
        return;
    end

    if _G.IsAltKeyDown() then
        _G.InviteByName(player);
        return;
    end

    if _G.IsShiftKeyDown() and _G.ChatFrameEditBox:IsVisible() then
        -- Player links don't have a color specified by default, but a color
        -- is required to send a link in a chat message. As a result, we
        -- construct a brand new hyperlink instead of copying the existing
        -- link's string.
        color = color or DEFAULT_COLOR;
        _G.ChatFrameEditBox:Insert(ChatSuey.Hyperlink(uri, text, color));
        return;
    end

    if _G.IsControlKeyDown() then
        _G.TargetByName(player, true);
        return;
    end

    hooks[this].OnHyperlinkClick();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end