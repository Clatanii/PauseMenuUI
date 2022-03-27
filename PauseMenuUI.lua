-- Main table for "PauseMenuUI" data and functions.
PauseMenuUI = {
    Menus = {}, -- menu cache, so we can have more than one menu :p
    Internal = {Data = {CurrentMenu = nil, BlockedColumn = {}, MenuReady = false, CurrentMenuFocus = 0, ColumnPool = {}}} -- Internal code that SHOULD be kept to local script use ONLY
}

PauseMenuUI.Internal.PlaySound = function(Audio)
    PlaySoundFrontend(-1, Audio, 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
end

PauseMenuUI.Internal.IsColumnBlocked = function(Column)
    return PauseMenuUI.Internal.Data.BlockedColumn[tostring(Column)] or false
end

PauseMenuUI.SetMenuFocus = function(Data)
    if not PauseMenuUI.Internal.IsColumnBlocked(Data) then
        PauseMenuUI.Internal.Data.CurrentMenuFocus = Data

        BeginScaleformMovieMethodOnFrontend('SET_COLUMN_FOCUS')
        ScaleformMovieMethodAddParamInt(Data) --// column index // _loc7_
        ScaleformMovieMethodAddParamInt(1)-- // highlightIndex // _loc6_
        ScaleformMovieMethodAddParamInt(1) --// scriptSetUniqID // _loc4_
        ScaleformMovieMethodAddParamInt(0) --// scriptSetMenuState // _loc5_
        EndScaleformMovieMethod()
    end
end

PauseMenuUI.CloseAny = function(MenuID)
    PauseMenuUI.Internal.CloseMenu()
end

PauseMenuUI.Close = function(MenuID)
    if PauseMenuUI.Internal.Data.CurrentMenu == MenuID then
        PauseMenuUI.Internal.CloseMenu()
    end
end

PauseMenuUI.Internal.CloseMenu = function()
    SetFrontendActive(false)
    TriggerScreenblurFadeOut(1000)
    PauseMenuUI.Internal.PlaySound('QUIT')

    PauseMenuUI.Internal.Data.Buttons = {['0'] = {}, ['3'] = {}}
    PauseMenuUI.Internal.Data.ButtonRegister = {['0'] = 0, ['3'] = 0}
    PauseMenuUI.Internal.Data.RegisteredButtons = 0
    PauseMenuUI.Internal.Data.TextBox = {}
    PauseMenuUI.Internal.Data.Details = {}
    PauseMenuUI.Internal.Data.BlockedColumn = {}
    PauseMenuUI.Internal.Data.CurrentMenuFocus = 0
    PauseMenuUI.Internal.Data.ColumnPool = {}

    PauseMenuUI.Internal.Data.CurrentMenu = nil
    PauseMenuUI.Internal.Data.MenuReady = false
end

PauseMenuUI.Open = function(MenuID)
    if PauseMenuUI.Internal.Data.CurrentMenu == nil then
        assert(PauseMenuUI.Menus[MenuID] ~= nil, 'A menu with ID '..MenuID..' is not non-existing.')

        PauseMenuUI.Internal.Data.RegisteredButtons = 0
        PauseMenuUI.Internal.Data.LoadedButtons = 0

        TriggerScreenblurFadeIn(1000)
        ActivateFrontendMenu('FE_MENU_VERSION_CORONA', false, -1)
        PauseMenuActivateContext('FE_MENU_VERSION_CORONA')
        Wait(100) -- Requires a wait, because menu needs to be opened before it can be "edited"
        PauseMenuUI.Internal.Init(PauseMenuUI.Menus[MenuID].Header)
        PauseMenuUI.Internal.Data.CurrentMenu = MenuID

        CreateThread(function()
            Wait(2000)
            PauseMenuUI.Internal.Data.MenuReady = true
        end)
    end
end

-- Create a menu, this is the "root" of the menu, MenuID is required to be a string.
PauseMenuUI.CreateMenu = function(MenuID, Title, Subtitle, MenuHeader, ListHeader, DetailHeader)
    assert(PauseMenuUI.Menus[MenuID] == nil, 'A menu with ID '..MenuID..' is already existing.')
    assert(type(MenuID) == 'string', '"MenuID" is required to be a string.')
    
    PauseMenuUI.Menus[MenuID] = {
        Header = {
            Title = Title,
            Subtitle = Subtitle,
            MenuHeader = MenuHeader,
            ListHeader = ListHeader,
            DetailHeader = DetailHeader,
        },
    }

    return MenuID
end

-- Main menu handle, handle your menu inside of this!
PauseMenuUI.Handle = function(MenuID, cb)
    CreateThread(function()
        while true do Wait(1)
            if PauseMenuUI.Internal.Data.CurrentMenu == MenuID and PauseMenuUI.Internal.Data.MenuReady then
                cb()

                -- Handle buttons in real-time
                if (PauseMenuUI.Internal.Data.LoadedButtons or 0) < PauseMenuUI.Internal.Data.RegisteredButtons or PauseMenuUI.Internal.Data.ForceFlush then
                    PauseMenuUI.Internal.RenderButtons()

                    PauseMenuUI.Internal.Data.ForceFlush = false
                elseif (PauseMenuUI.Internal.Data.LoadedButtons or 0) > PauseMenuUI.Internal.Data.RegisteredButtons then
                    PauseMenuUI.Internal.Data.Buttons = {['0'] = {}, ['3'] = {}}
                    PauseMenuUI.Internal.Data.LoadedButtons = 0
                end

                PauseMenuUI.Internal.Data.RegisteredButtons = 0
                PauseMenuUI.Internal.Data.ButtonRegister = {['0'] = 0, ['3'] = 0}

                -- Handle details page
                PauseMenuUI.Internal.RenderDetails()

                PauseMenuUI.Internal.Data.Details = {}

                -- Handle textbox page(s)
                PauseMenuUI.Internal.RenderTextBox()

                PauseMenuUI.Internal.Data.TextBox = {}
            end
        end
    end)
end

-- Set the main header details, this should be done right after creating the main menu.
PauseMenuUI.SetHeaderDetails = function(MenuID, ShowPlayerCard, ShowHeaderStrip, HeaderColor, StripColor, MenuFocus)
    assert(PauseMenuUI.Menus[MenuID] ~= nil, 'A menu with ID '..MenuID..' is not non-existing.')

    PauseMenuUI.Menus[MenuID].Header.ShowPlayerCard = ShowPlayerCard
    PauseMenuUI.Menus[MenuID].Header.ShowHeaderStrip = ShowHeaderStrip
    PauseMenuUI.Menus[MenuID].Header.HeaderColor = HeaderColor
    PauseMenuUI.Menus[MenuID].Header.StripColor = StripColor
    PauseMenuUI.Menus[MenuID].Header.MenuFocus = MenuFocus
end