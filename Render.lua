PauseMenuUI.Internal.Data.LoadedButtons = 0
PauseMenuUI.Internal.Data.ForceFlush = false
PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus = 0

PauseMenuUI.Internal.HandleManuallyClose = function()
    if IsDisabledControlJustReleased(0, 200) then
        PauseMenuUI.Internal.CloseMenu()
    end
end

PauseMenuUI.Internal.HandleHeaderMenuFocus = function()
    BeginScaleformMovieMethodOnFrontendHeader('HIGHLIGHT_MENU')
    ScaleformMovieMethodAddParamInt(PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus)
    EndScaleformMovieMethodReturnValue()

    if IsDisabledControlJustPressed(0, 153) then -- Right / E
        if PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus + 1 ~= 3 then
            PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus = PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus + 1
            PauseMenuUI.Internal.PlaySound('SELECT')
            PauseMenuUI.Internal.Data.TriggeredAutoActive = true
            PauseMenuUI.Internal.Data.ForceFlush = true

            if PauseMenuUI.Internal.Data.CurrentMenuFocus ~= 0 then
                PauseMenuUI.SetMenuFocus(0)
            end

            Wait(1)
        end
    end

    if IsDisabledControlJustPressed(0, 152) then -- Left / Q
        if PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus - 1 ~= -1 then
            PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus = PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus - 1
            PauseMenuUI.Internal.PlaySound('SELECT')
            PauseMenuUI.Internal.Data.TriggeredAutoActive = true
            PauseMenuUI.Internal.Data.ForceFlush = true

            if PauseMenuUI.Internal.Data.CurrentMenuFocus ~= 0 then
                PauseMenuUI.SetMenuFocus(0)
            end

            Wait(1)
        end
    end
end

PauseMenuUI.Internal.Init = function(Header)
    BeginScaleformMovieMethodOnFrontendHeader('SHIFT_CORONA_DESC')
    ScaleformMovieMethodAddParamBool(true) --shifts the column Headers a bit down.
    ScaleformMovieMethodAddParamBool(Header.ShowHeaderStrip) --This disables the colored strip above column Headers.
    EndScaleformMovieMethod()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SET_HEADER_TITLE')
    ScaleformMovieMethodAddParamTextureNameString(Header.Title)       -- // Set the title
    ScaleformMovieMethodAddParamBool(false)        -- // purpose unknown, is always 0 in decompiled scripts.
    ScaleformMovieMethodAddParamTextureNameString(Header.Subtitle)    --// set the subtitle.
    ScaleformMovieMethodAddParamBool(false)          --// setting this to true distorts the Header... for some reason. On normal MP_PAUSE menu, it makes the title a bit smaller.
    EndScaleformMovieMethod()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SHOW_HEADING_DETAILS') --disables right side player mockshot and cash / bank
    ScaleformMovieMethodAddParamBool(Header.ShowPlayerCard) --toggle
    EndScaleformMovieMethod()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SHOW_MENU') --disables the column Headers
    ScaleformMovieMethodAddParamBool(true) --toggle
    EndScaleformMovieMethod()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_HEADER_TEXT_BY_INDEX') --Changes the column Header text
    ScaleformMovieMethodAddParamInt(0) --// columnID. Starts at 0
    ScaleformMovieMethodAddParamTextureNameString(Header.MenuHeader) --column text
    ScaleformMovieMethodAddParamInt(1) --// Column width. 1 = default / 100%
    ScaleformMovieMethodAddParamBool(false) --forces UPPER TEXT for the column text.
    EndScaleformMovieMethodReturnValue()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_ITEM_COLOUR')  --Changes the column Header colored strip
    ScaleformMovieMethodAddParamInt(0) --// column
    ScaleformMovieMethodAddParamInt(Header.StripColor) --// colorID
    EndScaleformMovieMethodReturnValue()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_ITEM_COLOUR')  --Changes the column Header colored strip
    ScaleformMovieMethodAddParamInt(1) --// column
    ScaleformMovieMethodAddParamInt(Header.StripColor) --// colorID
    EndScaleformMovieMethodReturnValue()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_ITEM_COLOUR')  --Changes the column Header colored strip
    ScaleformMovieMethodAddParamInt(2) --// column
    ScaleformMovieMethodAddParamInt(Header.StripColor) --// colorID
    EndScaleformMovieMethodReturnValue()
    Wait(10)

    BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_HEADER_TEXT_BY_INDEX') --Changes the column Header text
    ScaleformMovieMethodAddParamInt(2) --// columnID. Starts at 0
    ScaleformMovieMethodAddParamTextureNameString(Header.DetailHeader)
    ScaleformMovieMethodAddParamInt(1) --// Column width. 1 = default / 100%
    ScaleformMovieMethodAddParamBool(false) --forceUpper...don't really know what it does. Setting it to true will hide? the column text
    EndScaleformMovieMethodReturnValue()
    Wait(10)

    if Header.AllowHeadIndex then
        BeginScaleformMovieMethodOnFrontendHeader('SET_ALL_HIGHLIGHTS') --Changes the column Header block color
        ScaleformMovieMethodAddParamInt(0) --// toggle
        ScaleformMovieMethodAddParamInt(Header.HeaderColor) --// colorID
        EndScaleformMovieMethodReturnValue()
        Wait(10)
    else
        BeginScaleformMovieMethodOnFrontendHeader('SET_ALL_HIGHLIGHTS') --Changes the column Header block color
        ScaleformMovieMethodAddParamInt(1) --// toggle
        ScaleformMovieMethodAddParamInt(Header.HeaderColor) --// colorID
        EndScaleformMovieMethodReturnValue()
        Wait(10)
    end

    BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_HEADER_TEXT_BY_INDEX') --Changes the column Header text
    ScaleformMovieMethodAddParamInt(1) --// columnID. Starts at 0
    ScaleformMovieMethodAddParamTextureNameString(Header.ListHeader)
    ScaleformMovieMethodAddParamInt(1) --// Column width. 1 = default / 100%
    ScaleformMovieMethodAddParamBool(false) --forceUpper...don't really know what it does. Setting it to true will hide? the column text
    EndScaleformMovieMethodReturnValue()

    BeginScaleformMovieMethodOnFrontend('SET_COLUMN_FOCUS')
    ScaleformMovieMethodAddParamInt(Header.MenuFocus) --// column index // _loc7_
    ScaleformMovieMethodAddParamInt(1)-- // highlightIndex // _loc6_
    ScaleformMovieMethodAddParamInt(1) --// scriptSetUniqID // _loc4_
    ScaleformMovieMethodAddParamInt(0) --// scriptSetMenuState // _loc5_
    EndScaleformMovieMethod()
end

PauseMenuUI.Internal.RenderDetails = function()
    local Details = PauseMenuUI.Internal.Data.Details

    if Details.LeftSideText and not PauseMenuUI.Internal.IsColumnBlocked(2) then
        BeginScaleformMovieMethodOnFrontend('SET_COLUMN_TITLE')
        ScaleformMovieMethodAddParamInt(1) --// some sort of type. Using 1 lets you create Title card.
        ScaleformMovieMethodAddParamTextureNameString('') --when 'type is 2', this is a column header.
        ScaleformMovieMethodAddParamTextureNameString(Details.LeftSideText) --when 'type is 2', this is a left side text. If it's 1, then it's the title
        ScaleformMovieMethodAddParamTextureNameString(Details.RightSideText) --when 'type is 2', this is right text.
        ScaleformMovieMethodAddParamTextureNameString(Details.TextureDic or '') --TextureDirectory for column img
        ScaleformMovieMethodAddParamTextureNameString(Details.TextureName or '')  --TextureName for column img
        ScaleformMovieMethodAddParamInt(1) --// idk, unused?
        ScaleformMovieMethodAddParamInt(2) --setting this to 1, makes the img squashed.
        ScaleformMovieMethodAddParamTextureNameString(Details.RP or 0) --RP value
        ScaleformMovieMethodAddParamTextureNameString(Details.Cash or 0) --Cash value
        ScaleformMovieMethodAddParamTextureNameString(Details.AP or 0) --Ap value
        EndScaleformMovieMethod()

        -- Wonder how the fuck you remove this after it has been rendered once?
        --[[ if type(Details.Warning) == 'table' then
            BeginScaleformMovieMethodOnFrontend('SET_COLUMN_TITLE')
            ScaleformMovieMethodAddParamInt(2) --// some sort of type. Using 1 lets you create Title card. type 2 = warning/alert/error tile below the column.
            ScaleformMovieMethodAddParamTextureNameString(Details.Warning.Header) --when 'type is 2', this is a column header.
            ScaleformMovieMethodAddParamTextureNameString(Details.Warning.LeftSideText) --when 'type is 2', this is a left side text. If it's 1, then it's the title
            ScaleformMovieMethodAddParamTextureNameString(Details.Warning.RightSideText) --when 'type is 2', this is right text.
            EndScaleformMovieMethod()
        end ]]

        if type(Details.Rows) == 'table' then
            for index, item in pairs(Details.Rows) do
                BeginScaleformMovieMethodOnFrontend('SET_DATA_SLOT')
                ScaleformMovieMethodAddParamInt(1) --// column
                ScaleformMovieMethodAddParamInt(index-1) --// index
                ScaleformMovieMethodAddParamInt(0) --// menu ID 0
                ScaleformMovieMethodAddParamInt(index) --// unique ID 0
                ScaleformMovieMethodAddParamInt(1) --// type 0
                ScaleformMovieMethodAddParamInt(0) --// initialIndex 0
                ScaleformMovieMethodAddParamBool(false) --// isSelectable true
                ScaleformMovieMethodAddParamTextureNameString(item.LeftText or item[1])
                ScaleformMovieMethodAddParamTextureNameString(item.RightText or item[2]) --Right Text
                EndScaleformMovieMethod()
            end
        end

        BeginScaleformMovieMethodOnFrontend('DISPLAY_DATA_SLOT')
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethodOnFrontend('SET_DATA_SLOT_EMPTY')
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()
    end
end

PauseMenuUI.Internal.RenderLockedMenus = function()
    local free_menu_index = 0

    for i, item in pairs(PauseMenuUI.Internal.Data.BlockedMenus) do

        if free_menu_index == i then
            free_menu_index = free_menu_index + 1
        end

        BeginScaleformMovieMethodOnFrontendHeader('SET_MENU_ITEM_ALERT')
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamTextureNameString('UNAVALIABLE')
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethodReturnValue()
    end


    if PauseMenuUI.Internal.Data.BlockedMenus[PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus] then
        PauseMenuUI.Internal.Data.CurrentMenuHeaderFocus = free_menu_index
    end
end

PauseMenuUI.Internal.RenderTextBox = function()
    local TextBox = PauseMenuUI.Internal.Data.TextBox

    if TextBox.Column == nil then
        PauseMenuUI.Internal.Data.BlockedColumn = {}

        BeginScaleformMovieMethodOnFrontend('SHOW_WARNING_MESSAGE')
        ScaleformMovieMethodAddParamInt(0)
        EndScaleformMovieMethod()
    else
        if TextBox.Column ~= 0 and TextBox.Column < 4 then
            BeginScaleformMovieMethodOnFrontend('SHOW_WARNING_MESSAGE')
            ScaleformMovieMethodAddParamInt(1) --showToggle
            if TextBox.Column < 3 then
                ScaleformMovieMethodAddParamInt(TextBox.Column) --column from where to start.
                ScaleformMovieMethodAddParamInt(1) --columns to cover.
            elseif TextBox.Column == 3 then
                ScaleformMovieMethodAddParamInt(1) --column from where to start.
                ScaleformMovieMethodAddParamInt(2) --columns to cover.
            end
            ScaleformMovieMethodAddParamTextureNameString(TextBox.Text) --body String.
            ScaleformMovieMethodAddParamTextureNameString(TextBox.Title) --title String.
            ScaleformMovieMethodAddParamInt(0) --background height?
            ScaleformMovieMethodAddParamTextureNameString(TextBox.TextureDic or '') --textureDictionary
            ScaleformMovieMethodAddParamTextureNameString(TextBox.TextureName or '') --textureName
            ScaleformMovieMethodAddParamInt(0) --image Alignment. (Probably justify. 0 = left)
            ScaleformMovieMethodAddParamTextureNameString(TextBox.Footer) --footer String.
            ScaleformMovieMethodAddParamInt(0) --request background texture.
            EndScaleformMovieMethod()
        end
    end
end

PauseMenuUI.Internal.RenderButtons = function()
    -- Render buttons
    for index, column in ipairs(PauseMenuUI.Internal.Data.ColumnPool) do
        if not PauseMenuUI.Internal.IsColumnBlocked(column) then
            BeginScaleformMovieMethodOnFrontend('SET_DATA_SLOT_EMPTY')
            ScaleformMovieMethodAddParamInt(column) -- column I guess?
            EndScaleformMovieMethod()

            -- Render "go-back" button for column 3
            if PauseMenuUI.Internal.Data.ButtonRegister[tostring(column)] > 0 and column == 3 then
                PauseMenuUI.AddButton(3, 'Go Back', 'Go back to the previous menu.', {Color = 9}, function(Hover, Selected, Active)
                    if Selected then
                        PauseMenuUI.SetMenuFocus(0)
                    end
                end)
            end

            for i, item in pairs(PauseMenuUI.Internal.Data.Buttons[tostring(column)]) do
                BeginScaleformMovieMethodOnFrontend('SET_DATA_SLOT')
                ScaleformMovieMethodAddParamInt(item.Column) --// column
                ScaleformMovieMethodAddParamInt(item.ButtonID) --// index
                ScaleformMovieMethodAddParamInt(0) --// menu ID 0
                ScaleformMovieMethodAddParamInt(item.ButtonID) --// unique ID 0

                if item.Column == 0 then
                    ScaleformMovieMethodAddParamInt(1) --// type 0
                    ScaleformMovieMethodAddParamInt(0) --// initialIndex 0
                    ScaleformMovieMethodAddParamBool(item.Style.Disable or true) --// isSelectable true
                    ScaleformMovieMethodAddParamTextureNameString(item.Text) -- left side text
                    ScaleformMovieMethodAddParamInt(item.Style.RockstarLogo or false) -- Rockstar logo 
                    ScaleformMovieMethodAddParamTextureNameString('0')
                    ScaleformMovieMethodAddParamTextureNameString(item.Style.RightText or item.Style.Symbol or '') -- input for symbol or text?
                    ScaleformMovieMethodAddParamInt(0) -- something related to color? 
                    ScaleformMovieMethodAddParamInt(1) --unused?
                    ScaleformMovieMethodAddParamInt(1) --unused?
                    ScaleformMovieMethodAddParamInt(0) --This makes the first button (only the first) flicker
                    if PauseMenuUI.Internal.Data.Buttons[item.ButtonID+1] ~= nil then
                        ScaleformMovieMethodAddParamInt(0) --This adds the bar above the button. Does not work for first button.
                    else
                        if item.Style.Bar then -- always makes a white bar line, not sure how to set color?
                            ScaleformMovieMethodAddParamInt(1) --This adds the bar above the button. Does not work for first button.
                        end
                    end
                    ScaleformMovieMethodAddParamInt(0) --unused?
                    ScaleformMovieMethodAddParamInt(0) --'Green Checkmark' icon
                else
                    ScaleformMovieMethodAddParamInt(item.Style.Type or 1)                     -- // type (2 = AS_ONLINE_IN_SESSION)
                    ScaleformMovieMethodAddParamInt(0)         -- // rank value / (initialIndex 1337)
                    ScaleformMovieMethodAddParamBool(false)                -- // isSelectable
                    ScaleformMovieMethodAddParamTextureNameString(item.Text)    --  // playerName
                    ScaleformMovieMethodAddParamInt(item.Style.Color)     --  // rowColor
                    ScaleformMovieMethodAddParamBool(true)               --  // reduceColors (if 'false' then shows the color of the row on the left side, else removes color from left bar)
                    ScaleformMovieMethodAddParamInt(0)                    --  // unused
                    ScaleformMovieMethodAddParamInt(item.Style.Symbol)         --  // right player icon.
                    ScaleformMovieMethodAddParamInt(0)                    --  // unused
                    ScaleformMovieMethodAddParamTextureNameString('')--  // crew label text. It's either broken, or I don't know how to translate Vespura's input.
                    ScaleformMovieMethodAddParamBool(false)               --  // should be a thing to toggle blinking of (kick) icon, but doesn't seem to work.
                    ScaleformMovieMethodAddParamTextureNameString(item.Style.RightText or 0)          -- // badge/status tag text
                    ScaleformMovieMethodAddParamInt(0)
                end
                EndScaleformMovieMethod()

                PauseMenuUI.Internal.Data.LoadedButtons = PauseMenuUI.Internal.Data.LoadedButtons + 1
            end

            BeginScaleformMovieMethodOnFrontend('DISPLAY_DATA_SLOT')
            ScaleformMovieMethodAddParamInt(column)
            EndScaleformMovieMethod()
        else
            PauseMenuUI.Internal.Data.LoadedButtons = PauseMenuUI.Internal.Data.LoadedButtons + 1

            BeginScaleformMovieMethodOnFrontend('SET_DATA_SLOT_EMPTY')
            ScaleformMovieMethodAddParamInt(column)
            EndScaleformMovieMethod()
        end
    end

    -- set focus
    PauseMenuUI.SetMenuFocus(PauseMenuUI.Internal.Data.CurrentMenuFocus)
end

PauseMenuUI.Internal.RenderToolTip = function(Text, Symbol)
    BeginScaleformMovieMethodN('SET_DESCRIPTION')
    PushScaleformMovieFunctionParameterInt(Symbol or 0) --This is a type. 0 is tooltip bellow buttons. 3 is a loading thing on the player column.
    PushScaleformMovieFunctionParameterString(Text)
    PushScaleformMovieMethodParameterInt(0) --toggle, Info icon flashing
    PushScaleformMovieMethodParameterInt(0) --togle, text flashing.
    EndScaleformMovieMethod()
end