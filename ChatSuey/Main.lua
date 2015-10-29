local _G = getfenv();
local ChatSuey = _G.ChatSuey;

local ARGB_PATTERN = "%x%x%x%x%x%x%x%x";

ChatSuey.Hyperlink = function (uri, text, color)
    local link = string.format("|H%s|h[%s]|h", uri, text);

    if color then
        color = ChatSuey.COLORS[string.upper(color)] or color;

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
    local _, _, scheme, path = string.find(uri, "^([^:]-):(.+)$");
    return scheme, path;
end;