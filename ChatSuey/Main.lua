local _G = getfenv();
local ChatSuey = _G.ChatSuey;

local ARGB_PATTERN = "%x%x%x%x%x%x%x%x";

ChatSuey.UriSchemes = {
    ITEM = "item",
    PLAYER = "player",
    TIME = "time",
    CHANNEL = "channel",
};

ChatSuey.Uri = function (scheme, path)
    return string.format("%s:%s", scheme, path);
end;

ChatSuey.Hyperlink = function (uri, text, color)
    local link = string.format("|H%s|h[%s]|h", uri, text);

    if color then
        color = ChatSuey.Colors[string.upper(color)] or color;

        if not string.find(color, ARGB_PATTERN) then
            error("Invalid color value: " .. color);
        end

        link = string.format("|c%s%s|r", color, link);
    end

    return link;
end;

ChatSuey.HyperlinkComponents = function (link)
    local _, _, color, scheme, path, text = string.find(link, "^|?c?(.-)|H(.-):(.-)|h%[(.-)%]|h|?r?$");

    if color == "" then
        color = nil;
    end

    return scheme, path, text, color;
end;

ChatSuey.UriComponents = function (uri)
    local _, _, scheme, path = string.find(uri, "^(.-):(.+)$");
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