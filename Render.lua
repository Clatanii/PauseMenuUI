PauseMenuUI.Internal.Data.LoadedButtons = 0

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

    BeginScaleformMovieMethodOnFrontendHeader('SHOW_HEADINGDetails') --disables right side player mockshot and cash / bank
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

    BeginScaleformMovieMethodOnFrontendHeader('SET_ALL_HIGHLIGHTS') --Changes the column Header block color
    ScaleformMovieMethodAddParamInt(1) --// toggle
    ScaleformMovieMethodAddParamInt(Header.HeaderColor) --// colorID
    EndScaleformMovieMethodReturnValue()
    Wait(10)

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

    if Details.Type then
        BeginScaleformMovieMethodOnFrontend('SET_COLUMN_TITLE')
        ScaleformMovieMethodAddParamInt(Details.Type) --// some sort of type. Using 1 lets you create Title card.
        ScaleformMovieMethodAddParamTextureNameString(Details.Header) --when 'type is 2', this is a column header.
        ScaleformMovieMethodAddParamTextureNameString(Details.LeftSideText) --when 'type is 2', this is a left side text. If it's 1, then it's the title
        ScaleformMovieMethodAddParamTextureNameString(Details.RightSideText) --when 'type is 2', this is right text.
        ScaleformMovieMethodAddParamTextureNameString(Details.TextureDir or '') --TextureDirectory for column img
        ScaleformMovieMethodAddParamTextureNameString(Details.TextureName or '')  --TextureName for column img
        ScaleformMovieMethodAddParamInt(1) --// idk, unused?
        ScaleformMovieMethodAddParamInt(2) --setting this to 1, makes the img squashed.
        ScaleformMovieMethodAddParamTextureNameString(Details.RP or 0) --RP value
        ScaleformMovieMethodAddParamTextureNameString(Details.Cash or 0) --Cash value
        ScaleformMovieMethodAddParamTextureNameString(Details.AP or 0) --Ap value
        EndScaleformMovieMethod()

        if type(Details.Warning) == 'table' then
            BeginScaleformMovieMethodOnFrontend('SET_COLUMN_TITLE')
            ScaleformMovieMethodAddParamInt(Details.Warning.Type) --// some sort of type. Using 1 lets you create Title card. type 2 = warning/alert/error tile below the column.
            ScaleformMovieMethodAddParamTextureNameString(Details.Warning.Header) --when 'type is 2', this is a column header.
            ScaleformMovieMethodAddParamTextureNameString(Details.Warning.LeftSideText) --when 'type is 2', this is a left side text. If it's 1, then it's the title
            ScaleformMovieMethodAddParamTextureNameString(Details.Warning.RightSideText) --when 'type is 2', this is right text.
            EndScaleformMovieMethod()
        end

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
                ScaleformMovieMethodAddParamTextureNameString(item.LeftText)
                ScaleformMovieMethodAddParamTextureNameString(item.RightText) --Right Text
                EndScaleformMovieMethod()
            end
        end

        BeginScaleformMovieMethodOnFrontend("DISPLAY_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethodOnFrontend('SHOW_COLUMN')
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethodOnFrontend('SHOW_WARNING_MESSAGE')
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()
    end
end

PauseMenuUI.Internal.SetMenuFocus = function(Data)
    PauseMenuUI.Internal.Data.CurrentMenuFocus = Data

    BeginScaleformMovieMethodOnFrontend('SET_COLUMN_FOCUS')
    ScaleformMovieMethodAddParamInt(Data) --// column index // _loc7_
    ScaleformMovieMethodAddParamInt(1)-- // highlightIndex // _loc6_
    ScaleformMovieMethodAddParamInt(1) --// scriptSetUniqID // _loc4_
    ScaleformMovieMethodAddParamInt(0) --// scriptSetMenuState // _loc5_
    EndScaleformMovieMethod()
end

PauseMenuUI.Internal.RenderHandle = function()
    
    -- Render buttons
    for index, column in ipairs(PauseMenuUI.Internal.Data.ColumnPool) do
        if not PauseMenuUI.Internal.Data.BlockedButtonColumns[tostring(column)] then
            BeginScaleformMovieMethodOnFrontend('SET_DATA_SLOT_EMPTY')
            ScaleformMovieMethodAddParamInt(column) -- column I guess?
            EndScaleformMovieMethod()

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
                    ScaleformMovieMethodAddParamTextureNameString(item.Style.RockstarLogo or false) --Setting this as a number string will show the Rockstar logo on the button. // What? Seems more like it makes the button blink a bit
                    ScaleformMovieMethodAddParamInt(item.Style.Symbol or 0) --0 = shows raw rightText. 1 = Star symbol, 2 = skull, 3 = race flag, 4 = shield with cross(TDM?), 5 = multiple skulls, 6 - blank, 7 = castle, 9 = parachute, 10 = car with explosion.
                    ScaleformMovieMethodAddParamTextureNameString('0') -- have to call this '0' to be able to set RightText in the next call
                    ScaleformMovieMethodAddParamTextureNameString(item.Style.RightText or '')
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
                    ScaleformMovieMethodAddParamTextureNameString(0)          -- // badge/status tag text
                    ScaleformMovieMethodAddParamInt(0)
                end
                EndScaleformMovieMethod()

                PauseMenuUI.Internal.Data.LoadedButtons = PauseMenuUI.Internal.Data.LoadedButtons + 1
            end
            Citizen.Wait(10)
            BeginScaleformMovieMethodOnFrontend('DISPLAY_DATA_SLOT')
            ScaleformMovieMethodAddParamInt(column)
            EndScaleformMovieMethod()
        end
    end

    -- set focus
    PauseMenuUI.Internal.SetMenuFocus(PauseMenuUI.Internal.Data.CurrentMenuFocus)
end

PauseMenuUI.Internal.RenderToolTip = function(Text, Symbol)
    BeginScaleformMovieMethodN('SET_DESCRIPTION')
    PushScaleformMovieFunctionParameterInt(Symbol or 0) --This is a type. 0 is tooltip bellow buttons. 3 is a loading thing on the player column.
    PushScaleformMovieFunctionParameterString(Text)
    PushScaleformMovieMethodParameterInt(0) --toggle, Info icon flashing
    PushScaleformMovieMethodParameterInt(0) --togle, text flashing.
    EndScaleformMovieMethod()
end