PauseMenuUI.Internal.Data.Details = {}

PauseMenuUI.Details = function(RightSideText, TexDic, TexName, Warning, Rows)

    PauseMenuUI.Internal.Data.Details = {
        Rows = Rows,
        LeftSideText = RightSideText,
        RightSideText = '',
        TextureDic = TexDic,
        TextureName = TexName,
        Warning = Warning,
    }
end