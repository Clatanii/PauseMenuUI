PauseMenuUI.Internal.Data.Buttons = {['0'] = {}, ['3'] = {}}
PauseMenuUI.Internal.Data.ButtonRegister = {['0'] = 0, ['3'] = 0}
PauseMenuUI.Internal.Data.RegisteredButtons = 0
PauseMenuUI.Internal.Data.LastButton = -1
PauseMenuUI.Internal.Data.TriggeredAutoActive = false

local AddToPool = function(Column)
    for index, column in ipairs(PauseMenuUI.Internal.Data.ColumnPool) do
        if column == Column then
            return
        end
    end

    table.insert(PauseMenuUI.Internal.Data.ColumnPool, Column)
end

local GetLoadedButtons = function(Column)
    local count = 0

    for i, item in pairs(PauseMenuUI.Internal.Data.Buttons[tostring(Column)]) do
        count = count + 1
    end    
    
    return count
end

PauseMenuUI.AddButton = function(Column, Text, Desc, Style, cb)

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
    local Active = false
    local _, ButtonPointer = GetPauseMenuSelection()

    if Column == PauseMenuUI.Internal.Data.CurrentMenuFocus and PauseMenuUI.Internal.Data.Buttons[tostring(Column)][tostring(button_id)].ButtonID == ButtonPointer then
        Hover = true

        if PauseMenuUI.Internal.Data.LastButton ~= ButtonPointer then
            Active = true
        else
            if GetLoadedButtons(Column) and PauseMenuUI.Internal.Data.TriggeredAutoActive then
                PauseMenuUI.Internal.Data.TriggeredAutoActive = false
                ButtonPointer = -1
            end
        end

        PauseMenuUI.Internal.Data.LastButton = ButtonPointer

        PauseMenuUI.Internal.RenderToolTip(Desc, Style.DescSymbol)
    end

    if IsControlJustPressed(0, 191) and Column == PauseMenuUI.Internal.Data.CurrentMenuFocus and PauseMenuUI.Internal.Data.Buttons[tostring(Column)][tostring(button_id)].ButtonID == ButtonPointer then
        Selected = true

        PauseMenuUI.Internal.PlaySound('SELECT')
        Wait(1)
    end

    if type(cb) == 'function' then cb(Hover, Selected, Active) end

    return button_id
end