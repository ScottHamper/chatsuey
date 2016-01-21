local ChatSuey = _G.ChatSuey;

local ARGB_PATTERN = ("%x"):rep(8);

ChatSuey.UriSchemes = {
    ACHIEVEMENT = "achievement",
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

-- SavedVariables are loaded after the addon has been parsed/executed,
-- but before the `ADDON_LOADED` event is fired. So we have to create a
-- frame just to listen for that event, in order to init our DB.
local eventFrame = _G.CreateFrame("FRAME");
eventFrame:RegisterEvent("ADDON_LOADED");

eventFrame:SetScript("OnEvent", function ()
    local addon = _G.arg1;

    if addon ~= "ChatSuey" then
        return;
    end

    _G.ChatSueyDB = _G.ChatSueyDB or {};
    ChatSuey.DB = _G.ChatSueyDB;
end);