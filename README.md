# ✨ PauseMenuUI
A framework built around "real-time" PauseMenu rendering.

# 🖋️ License
You are *not* allowed to sell this framework without the correct permissions from me (Clatanii#5199).

# 🔬 Use Of Framework
This framework is still in W.I.P but at the moment it is quite usable anyway.

## Setting up a menu

```lua
-- Create base menu handler
local MenuID = PauseMenuUI.CreateMenu('menu_id_string', 'Title', 'Subtitle', 'Header1', 'Header2', 'Header3')
-- MenuID, ShowPlayerCard, ShowHeaderStrip, HeaderColor, StripColor, BaseMenuFocus
PauseMenuUI.SetHeaderDetails(MenuID, true, true, 2, 6, 0)

-- Example variables
local bool = false
local details_page = {{LeftText = 'hehe', RightText = 'hehe2'}}
local details_show = false
local textbox_show = false

-- How to open the menu.
RegisterCommand('open_menu', function()
    PauseMenuUI.Open(MenuID)
end)

-- How to close the menu.
RegisterCommand('close_menu', function()
    PauseMenuUI.Close(MenuID)
    
    -- This would work as well, but would close ANY opened menu
    -- PauseMenuUI.CloseAny()
end)

-- This is the loop/handler for the menu, SHOULD always be run in this function as this is were the render handle is aswell
PauseMenuUI.Handle(MenuID, function()

    -- Add a button, first argument is "MenuFocus" int, 0 for first row, 3 for second row.
    PauseMenuUI.AddButton(3, 'Change menu', 'hola senorita', {RightText = '~c~Some text! :)'}, function(Hover, Selected)
        if Selected then
            PauseMenuUI.SetMenuFocus(0)
        end
    end)

    -- As this is real-time handling, we can add in buttons if a variable is true for example in "real-time" :D
    if bool then
        for i = 1, 3 do
            PauseMenuUI.AddButton(3, 'Button: '..i, 'this is a button!', {RightText = '~c~Some text! :)'}, function(Hover, Selected)

            end)
        end
    end

    -- Add a button in to toggle 3 new buttons.
    PauseMenuUI.AddButton(0, 'Toggle buttons!', 'Render 3 more buttons in real time :)', {RightText = '~c~wow right text'}, function(Hover, Selected)
        if Selected then
            bool = not bool
        end
    end)

    -- An example how to switch menu focus.
    PauseMenuUI.AddButton(0, 'Change Menu', 'Hola seniorita', {Symbol = 5, RockstarLogo = true}, function(Hover, Selected)
        if Selected then
            PauseMenuUI.SetMenuFocus(3)
        end
    end)

    -- An example on how to toggle the textbox page.
    PauseMenuUI.AddButton(0, 'Toggle textbox', 'Hola seniorita', {Symbol = 5, RockstarLogo = true}, function(Hover, Selected)
        if Selected then
            textbox_show = not textbox_show
        end
    end)

    -- Add more items to the details screen.
    PauseMenuUI.AddButton(0, 'Add details screen button!', nil, {}, function(Hover, Selected)
        if Selected then
            table.insert(details_page, {LeftText = #details_page, 'new one!', RightText = '??'})
        end
    end)

    -- An example on how to toggle the details screen.
    PauseMenuUI.AddButton(0, 'Toggle details page', nil, {}, function(Hover, Selected)
        if Selected then
            details_show = not details_show
        end
    end)

    -- handle details page if enabled
    if details_show then
        PauseMenuUI.Details('Some header...', 'right side', '', '', {Header = 'Important Message', LeftSideText = 'Fuck russia', RightSideText = '<3 Ukraine'}, details_page)
    end

    -- handle textbox page if enabled.
    if textbox_show then
        PauseMenuUI.TextBox(2, 'Title', 'Text', 'Footer')
    end
end)
```

⚠️ **This framework is still in early versions of development, DO NOT EXPECT things to work properly or as said.** ⚠️
