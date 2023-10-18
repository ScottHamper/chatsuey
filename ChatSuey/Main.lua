local ChatSuey = _G.ChatSuey;

local ARGB_PATTERN = ("%x"):rep(8);

ChatSuey.UriSchemes = {
    ACHIEVEMENT = "achievement",
    BATTLE_PET = "battlepet",
    ENCHANT = "enchant",
    GLYPH = "glyph",
    ITEM = "item",
    PLAYER = "player",
    QUEST = "quest",
    SPELL = "spell",
    TALENT = "talent",
    TRADE = "trade",

    TIME = "time",
    CHANNEL = "channel",
};

ChatSuey.Uri = function (scheme, path)
    return ("%s:%s"):format(scheme, path);
end;

ChatSuey.Hyperlink = function (uri, text, color)
    local link = ("|H%s|h[%s]|h"):format(uri, text);

    if color then
        color = ChatSuey.Colors[color:upper()] or color;

        if not color:find(ARGB_PATTERN) then
            error("Invalid color value: " .. color);
        end

        link = ("|c%s%s|r"):format(color, link);
    end

    return link;
end;

ChatSuey.HyperlinkComponents = function (link)
    local _, _, color, scheme, path, text = link:find("^|?c?(.-)|H(.-):(.-)|h%[(.-)%]|h|?r?$");

    if color == "" then
        color = nil;
    end

    return scheme, path, text, color;
end;

ChatSuey.UriComponents = function (uri)
    local _, _, scheme, path = uri:find("^(.-):(.+)$");
    return scheme, path;
end;

local readyChatFrames = { };
for i = 1, _G.NUM_CHAT_WINDOWS do
    table.insert(readyChatFrames, _G["ChatFrame" .. i]);
end

local onChatFrameReadyCallbacks = { };

-- When the "Social -> New Whispers" interface option is set
-- to "New Tab" or "Both", Blizz creates additional chat frames
-- that aren't part of the normal `_G.NUM_CHAT_WINDOWS` shtick.
-- We need to know when one of these "temporary" frames has been
-- created so that we can initialize our addon functionality.
_G.hooksecurefunc("ChatFrame_OnLoad", function (chatFrame)
    for _, readyChatFrame in ipairs(readyChatFrames) do
        if readyChatFrame == ChatFrame then
            return;
        end
    end

    table.insert(readyChatFrames, chatFrame);

    for _, callback in ipairs(onChatFrameReadyCallbacks) do
        callback(chatFrame);
    end
end);

ChatSuey.OnChatFrameReady = function (callback)
    table.insert(onChatFrameReadyCallbacks, callback);

    for _, chatFrame in ipairs(readyChatFrames) do
        callback(chatFrame);
    end
end;

-- SavedVariables are loaded after the addon has been parsed/executed,
-- but before the `ADDON_LOADED` event is fired. So we have to create a
-- frame just to listen for that event, in order to init our DB.
local eventFrame = _G.CreateFrame("FRAME");
eventFrame:RegisterEvent("ADDON_LOADED");

eventFrame:SetScript("OnEvent", function (self, event, addon)
    if event ~= "ADDON_LOADED" or addon ~= "ChatSuey" then
        return;
    end

    _G.ChatSueyDB = _G.ChatSueyDB or {};
    ChatSuey.DB = _G.ChatSueyDB;
end);
