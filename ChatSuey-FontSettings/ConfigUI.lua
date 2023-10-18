local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local LS = ChatSuey.Locales[_G.GetLocale()].Strings;

local ROOT_OPTION = {
    text = LS["Font"],
    hasArrow = true,
    notCheckable = true,
};

local SIZE_ROOT_OPTION = {
    text = LS["Size"],
    hasArrow = true,
};

local SPACER = {
    disabled = true,
};

local addHeader = function (text, level)
    local info = {
        text = text,
        isTitle = true,
        notClickable = true,
    };

    _G.UIDropDownMenu_AddButton(info, level);
end;

local sizeOption = function (chatFrame, size)
    local _, currentSize, _ = chatFrame:GetFont();

    return {
        text = _G.FONT_SIZE_TEMPLATE:format(size),
        value = size,
        checked = size == floor(currentSize + 0.5),
        func = function ()
            local file, _, flags = chatFrame:GetFont();
            chatFrame:SetFont(file, size, flags);
            _G.SetChatWindowSize(chatFrame:GetID(), size);
        end,
    };
end;

local outlineOption = function (chatFrame, text, value)
    local config = ChatSuey.DB.Config.Font[chatFrame:GetName()];

    return {
        text = text,
        checked = config.outline == value,
        func = function ()
            config.outline = value;
            ChatSuey.SetFont(chatFrame);
        end,
    };
end;

local familyOption = function (chatFrame, family)
    local config = ChatSuey.DB.Config.Font[chatFrame:GetName()];

    return {
        text = family.name,
        checked = config.path == family.path,
        func = function ()
            config.path = family.path;
            ChatSuey.SetFont(chatFrame);
        end,
    };
end;

local initialize = function (frame, level)
    if _G.UIDROPDOWNMENU_MENU_LEVEL == 1 then
        hooks[frame].initialize(level);
        local fontSizeIndex = ChatSuey.UIDropDownMenu_IndexOf(_G.FONT_SIZE);

        ChatSuey.UIDropDownMenu_ReplaceButton(1, fontSizeIndex, ROOT_OPTION);
        return;
    end

    if _G.UIDROPDOWNMENU_MENU_LEVEL == 2 and
       _G.UIDROPDOWNMENU_MENU_VALUE == ROOT_OPTION.text then
       local chatFrame = _G.FCF_GetCurrentChatFrame();

        _G.UIDropDownMenu_AddButton(SIZE_ROOT_OPTION, 2);
        _G.UIDropDownMenu_AddButton(SPACER, 2);

        addHeader(LS["Outline"], 2);
        _G.UIDropDownMenu_AddButton(outlineOption(chatFrame, LS["None"], ""), 2);
        _G.UIDropDownMenu_AddButton(outlineOption(chatFrame, LS["Thin"], "OUTLINE"), 2);
        _G.UIDropDownMenu_AddButton(outlineOption(chatFrame, LS["Thick"], "THICKOUTLINE"), 2);
        _G.UIDropDownMenu_AddButton(SPACER, 2);

        -- TODO: Dynamically enumerate fonts based off ChatSuey.Fonts table,
        -- but maintain ordering. Will make adding fonts later easier.
        addHeader(LS["Family"], 2);
        local fonts = ChatSuey.Fonts;
        _G.UIDropDownMenu_AddButton(familyOption(chatFrame, fonts.ARIAL_NARROW), 2);
        _G.UIDropDownMenu_AddButton(familyOption(chatFrame, fonts.FRIZ_QUADRATA), 2);
        _G.UIDropDownMenu_AddButton(familyOption(chatFrame, fonts.MORPHEUS), 2);
        _G.UIDropDownMenu_AddButton(familyOption(chatFrame, fonts.SKURRI), 2);
        return;
    end

    if _G.UIDROPDOWNMENU_MENU_LEVEL == 3 and
       _G.UIDROPDOWNMENU_MENU_VALUE == SIZE_ROOT_OPTION.text then
        local chatFrame = _G.FCF_GetCurrentChatFrame();

        for i = 8, 20 do
            _G.UIDropDownMenu_AddButton(sizeOption(chatFrame, i), 3);
        end
    end
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    local dropDown = _G[chatFrame:GetName() .. "TabDropDown"];

    hooks:RegisterFunc(dropDown, "initialize", function (level)
        initialize(dropDown, level);
    end);
end);