local _G = getfenv();
local ChatSuey = _G.ChatSuey;

-- Possible TODO: Do more validation on `color`, e.g., use default if not in `COLORS` or "%x%x%x%x%x%x%x%x"
ChatSuey.Hyperlink = function (uri, text, color)
    -- ENHANCEMENT: Allow configuring default color
    color = color or ChatSuey.COLORS.WHITE;
    color = ChatSuey.COLORS[string.upper(color)] or color;

    return string.format("|c%s|H%s|h[%s]|h|r", color, uri, text);
end;

ChatSuey.HyperlinkComponents = function (link)
    local _, _, color, scheme, path, text = string.find(link, "^|?c?(.-)|H(.-):(.-)|h%[(.-)%]|h|?r?$");

    -- Player hyperlinks do not have a color by default
    if color == "" then
        color = nil;
    end

    return scheme, path, text, color;
end;