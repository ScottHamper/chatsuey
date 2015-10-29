local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local DIALOG_NAME = "ChatSuey_WebLinkDialog";
local URL_PATTERN = "(|?%a[%w+.%-]-://[%w%-._~:/?#%[%]@!$&'()*+,;=%%]+)";
local LINK_COLOR = ChatSuey.COLORS.TOKEN;

local parseHyperlink = function (link)
    -- We don't want to replace the text of an existing chat hyperlink
    -- This is admittedly a rare edge case.
    if string.sub(link, 1, 1) == "|" then
        return link;
    end

    return ChatSuey.Hyperlink(link, link, LINK_COLOR);
end;

local addMessage = function (self, text, red, green, blue, messageId, holdTime)
    text = string.gsub(text, URL_PATTERN, parseHyperlink);
    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

local clickedUrl = "";

local onHyperlinkClick = function ()
    local uri = _G.arg1;
    local link = _G.arg2;
    local button = _G.arg3;

    if not string.find(uri, URL_PATTERN) then
        hooks[this].OnHyperlinkClick(this, uri, link, button);
        return;
    end

    if _G.IsShiftKeyDown() and _G.ChatFrameEditBox:IsVisible() then
        _G.ChatFrameEditBox:Insert(link);
        return;
    end

    clickedUrl = uri;
    StaticPopup_Show(DIALOG_NAME);
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end

_G.StaticPopupDialogs[DIALOG_NAME] = {
    text = "Copy the URL into your clipboard (Ctrl-C):",
    button1 = _G.CLOSE,
    timeout = 0,
    whileDead = true,
    hasEditBox = true,
    hasWideEditBox = true,
    maxLetters = 500,

    OnShow = function ()
        local editBox = _G[this:GetName() .. "WideEditBox"];
        editBox:SetText(clickedUrl);
        editBox:HighlightText();

        -- Fixes editBox bleeding out of the dialog boundaries
        this:SetWidth(editBox:GetWidth() + 80);

        -- Fixes close button overlapping the edit box
        local closeButton = _G[this:GetName() .. "Button1"];
        closeButton:ClearAllPoints();
        closeButton:SetPoint("CENTER", editBox, "CENTER", 0, -30);
    end,

    OnHide = function ()
        _G[this:GetName() .. "WideEditBox"]:SetText("");
        clickedUrl = "";
    end,

    EditBoxOnEscapePressed = function ()
        this:GetParent():Hide();
    end,

    EditBoxOnEnterPressed = function ()
        this:GetParent():Hide();
    end,
};