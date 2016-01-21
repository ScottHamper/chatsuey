local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local DIALOG_NAME = "ChatSuey_WebLinkDialog";
local URL_PATTERN = "(|?%a[%w+.%-]-://[%w%-._~:/?#%[%]@!$&'()*+,;=%%]+)";
local LINK_COLOR = ChatSuey.Colors.TOKEN;

ChatSuey.test = function ()
    ChatFrame1:AddMessage("|cffff0000http://google.com|r");
end;

local addMessage = function (self, text, ...)
    text = text:gsub(URL_PATTERN, function (link)
        -- Players can't send custom hyperlinks in chat in WotLK,
        -- but some private servers broadcast messages to users with
        -- URLs wrapped in a color, e.g., "|cffff0000http://google.com|r"
        if link:sub(1, 2) == "|c" then
            link = link:sub(11);
        end

        return ChatSuey.Hyperlink(link, link, LINK_COLOR);
    end);

    hooks[self].AddMessage(self, text, ...);
end;

local clickedUrl = "";

local onHyperlinkClick = function (self, uri, ...)
    if not uri:find(URL_PATTERN) then
        hooks[self].OnHyperlinkClick(self, uri, ...);
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