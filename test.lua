local MenuID = PauseMenuUI.CreateMenu('1', 'test', 'hello', 'WHAt', 'THE', 'FUCK')
PauseMenuUI.SetHeaderDetails(MenuID, true, true, 2, 6, 0)

local bool = false
local details_page = {{LeftText = 'hehe', RightText = 'hehe2'}}
local details_show = false
local textbox_show = false

RegisterCommand('open_menu', function()
    PauseMenuUI.Open(MenuID)
end)

PauseMenuUI.Handle(MenuID, function()
    PauseMenuUI.AddButton(3, 'Change menu', 'hola senorita', {RightText = '~c~Some text! :)'}, function(Hover, Selected)
        if Selected then
            PauseMenuUI.SetMenuFocus(0)
        end
    end)

    if bool then
        for i = 1, 3 do
            PauseMenuUI.AddButton(3, 'Button: '..i, 'this is a button!', {RightText = '~c~Some text! :)'}, function(Hover, Selected)

            end)
        end
    end

    PauseMenuUI.AddButton(0, 'Toggle buttons!', 'Render 3 more buttons in real time :)', {RightText = '~c~wow right text'}, function(Hover, Selected)
        if Selected then
            bool = not bool
        end
    end)

    PauseMenuUI.AddButton(0, 'Change Menu', 'Hola seniorita', {Symbol = 5, RockstarLogo = true}, function(Hover, Selected)
        if Selected then
            PauseMenuUI.SetMenuFocus(3)
        end
    end)

    PauseMenuUI.AddButton(0, 'Toggle textbox', 'Hola seniorita', {Symbol = 5, RockstarLogo = true}, function(Hover, Selected)
        if Selected then
            textbox_show = not textbox_show
        end
    end)

    PauseMenuUI.AddButton(0, 'Add details screen button!', nil, {}, function(Hover, Selected)
        if Selected then
            table.insert(details_page, {LeftText = #details_page, 'new one!', RightText = '??'})
        end
    end)

    PauseMenuUI.AddButton(0, 'Toggle details page', nil, {}, function(Hover, Selected)
        if Selected then
            details_show = not details_show
        end
    end)

    if details_show then
        PauseMenuUI.Details('Some header...', 'right side', '', '', {Header = 'Important Message', LeftSideText = 'Fuck russia', RightSideText = '<3 Ukraine'}, details_page)
    end

    if textbox_show then
        PauseMenuUI.TextBox(2, 'Title', 'Text', 'Footer')
    end
end)