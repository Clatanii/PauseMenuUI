PauseMenuUI.Internal.Data.Buttons = {['0'] = {}, ['3'] = {}}
PauseMenuUI.Internal.Data.ButtonRegister = {['0'] = 0, ['3'] = 0}
PauseMenuUI.Internal.Data.RegisteredButtons = 0
PauseMenuUI.Internal.Data.BlockedButtonColumns = {}
PauseMenuUI.Internal.Data.IsInputBlocked = false

local AddToPool = function(Column)
    for index, column in ipairs(PauseMenuUI.Internal.Data.ColumnPool) do
        if column == Column then
            return
        end
    end

    table.insert(PauseMenuUI.Internal.Data.ColumnPool, Column)
end

PauseMenuUI.Internal.BlockButtonColumn = function(Column, Bool)
    PauseMenuUI.Internal.Data.BlockedButtonColumns[Column] = Bool
end

PauseMenuUI.AddButton = function(MenuID, Column, Text, Desc, Style, cb)

    -- get 'button_id'
    local button_id = PauseMenuUI.Internal.Data.ButtonRegister[tostring(Column)]

    -- register button
    button_id = button_id + 1

    PauseMenuUI.Internal.Data.Buttons[tostring(Column)][tostring(button_id)] = {
        Column = Column,
        ButtonID = button_id - 1,
        Text = Text,
        Desc = Desc or '',
        Style = Style or {},
    }

    AddToPool(Column)

    PauseMenuUI.Internal.Data.RegisteredButtons = PauseMenuUI.Internal.Data.RegisteredButtons + 1
    PauseMenuUI.Internal.Data.ButtonRegister[tostring(Column)] = PauseMenuUI.Internal.Data.ButtonRegister[tostring(Column)] + 1

    -- user control handle
    local Hover = false
    local Selected = false
    local _, ButtonPointer = GetPauseMenuSelection()

    if Column == PauseMenuUI.Internal.Data.CurrentMenuFocus and PauseMenuUI.Internal.Data.Buttons[tostring(Column)][tostring(button_id)].ButtonID == ButtonPointer then
        Hover = true

        PauseMenuUI.Internal.RenderToolTip(Desc, Style.DescSymbol)
    end

    if IsControlJustPressed(0, 191) and Column == PauseMenuUI.Internal.Data.CurrentMenuFocus and PauseMenuUI.Internal.Data.Buttons[tostring(Column)][tostring(button_id)].ButtonID == ButtonPointer then
        Selected = true

        PauseMenuUI.Internal.PlaySound('SELECT')
        Wait(1)
    end

    cb(Hover, Selected)

    return button_id
end