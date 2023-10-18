local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local LS = ChatSuey.Locales[_G.GetLocale()].Strings;

local DIALOG_NAME = "ChatSuey_WebLinkDialog";
local DIALOG_PADDING = 80; -- Total horizontal padding around editBox
local EDIT_BOX_WIDTH = 500;
local LINK_COLOR = ChatSuey.Colors.TOKEN;

-- This pattern isn't full-proof, but we only need it to be "good enough"
local URL_PATTERN = "([%w+.%-]-://[%w%-._~:/?#%[%]@!$&'()*+,;=%%]+)";

local addMessage = function (self, text, ...)
    text = text:gsub(URL_PATTERN, function (url)
        -- Trim off any trailing punctuation from the url.
        url, punctuation = url:match("^(.-)([.,]*)$");

        return ChatSuey.Hyperlink(url, url, LINK_COLOR) .. punctuation;
    end);

    hooks[self].AddMessage(self, text, ...);
end;

local clickedUrl = "";

local onHyperlinkClick = function (self, uri, ...)
    if not uri:find(URL_PATTERN) then
        return;
    end

    clickedUrl = uri;

    local dialog = StaticPopup_Show(DIALOG_NAME);
    dialog:SetWidth(EDIT_BOX_WIDTH + DIALOG_PADDING);
    dialog.editBox:SetWidth(EDIT_BOX_WIDTH);
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    chatFrame:HookScript("OnHyperlinkClick", onHyperlinkClick);
end);

_G.StaticPopupDialogs[DIALOG_NAME] = {
    text = LS["Copy the URL into your clipboard (Ctrl-C):"],
    button1 = _G.CLOSE,
    timeout = 0,
    whileDead = true,
    hasEditBox = true,
    maxLetters = 500,

    OnShow = function (self)
        self.editBox:SetText(clickedUrl);
        self.editBox:HighlightText();
    end,

    OnHide = function (self)
        self.editBox:SetText("");
        clickedUrl = "";
    end,

    EditBoxOnEscapePressed = function (self)
        self:GetParent():Hide();
    end,

    EditBoxOnEnterPressed = function (self)
        self:GetParent():Hide();
    end,
};
