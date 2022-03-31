PauseMenuUI.Internal.Data.TextBox = {}

PauseMenuUI.TextBox = function(Column, Title, Text, Footer, TextureDic, TextureName)
    PauseMenuUI.Internal.Data.TextBox = {
        Column = Column,
        Title = Title,
        Text = Text,
        Footer = Footer,
        TextureDic = TextureDic,
        TextureName = TextureName,
    }

    -- 1 = column 1, 2 = column 2, 3 = column 1 & 2
    PauseMenuUI.Internal.Data.BlockedColumn = {}
    if Column == 1 then
        PauseMenuUI.Internal.Data.BlockedColumn['3'] = true 
    elseif Column == 2 then
        PauseMenuUI.Internal.Data.BlockedColumn['2'] = true 
    elseif Column == 3 then
        PauseMenuUI.Internal.Data.BlockedColumn['2'] = true
        PauseMenuUI.Internal.Data.BlockedColumn['3'] = true
    end

    PauseMenuUI.Internal.Data.ForceFlush = true
end