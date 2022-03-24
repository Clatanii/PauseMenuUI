PauseMenuUI.Internal.Data.Details = {}

PauseMenuUI.Details = function(MenuID, Type, Header, LeftSideText, RightSideText, TexDic, TexName, Warning, Rows)

    PauseMenuUI.Internal.Data.Details = {
        Type = Type,
        Rows = Rows,
        Header = Header,
        LeftSideText = LeftSideText,
        RightSideText = RightSideText,
        TextureDic = TexDic,
        TextureName = TexName,
        Warning = Warning,
    }
end