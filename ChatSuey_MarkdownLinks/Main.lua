local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local BASE_LINK_PATTERN = "%[([^%]]+)%]%((.+)%)";
local COLORED_LINK_PATTERN = BASE_LINK_PATTERN .. "{(.+)}";

local replaceFoundHyperlink = function (frame, matchTrailingSpace)
    local suffix = matchTrailingSpace and " " or "";
    local message = frame:GetText();
    local i, j, text, uri, color = string.find(message, COLORED_LINK_PATTERN .. suffix);
    
    if i == nil then
        i, j, text, uri = string.find(message, BASE_LINK_PATTERN .. suffix);
    end
    
    if i == nil then
        return;
    end
    
    frame:HighlightText(i - 1, j);
    frame:Insert(ChatSuey.Hyperlink(uri, text, color) .. suffix);
end;

hooks:RegisterScript(_G.ChatFrameEditBox, "OnSpacePressed", function ()
    hooks[this].OnSpacePressed(this);
    replaceFoundHyperlink(this, true);
end);

hooks:RegisterScript(_G.ChatFrameEditBox, "OnEnterPressed", function ()
    replaceFoundHyperlink(this);
    hooks[this].OnEnterPressed(this);
end);