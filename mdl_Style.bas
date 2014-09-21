Option Explicit

Private Const wdLineSpaceSingle = 0
Private Const wdAlignParagraphJustify = 3
Private Const wdAlignParagraphCenter = 1
Private Const wdAlignPageNumberCenter = 1
Private Const wdAlignParagraphRight = 2
Private Const wdAlignParagraphLeft = 0
Private Const wdOutlineLevel1 = 1
Private Const wdTrailingSpace = 1
Private Const wdListNumberStyleUppercaseRoman = 1
Private Const wdUndefined = &H98967F
Private Const wdPasteRTF = 1

Private Const wdListNumberStyleArabic = 0
Private Const wdListNumberStyleLowercaseLetter = 4
Private Const wdListNumberStyleNumberInCircle = &H12
Private Const wdListLevelAlignLeft = 0
Private Const wdTrailingTab = 0
Private Const wdOutlineNumberGallery = 3
Private Const wdLineSpaceMultiple = 5
Private Const wdPreferredWidthPercent = 2
Private Const wdPreferredWidthPoints = 3
Private Const wdRowHeightAtLeast = 1
Private Const wdReplaceAll = 2
Private Const wdFindContinue = 1

Private Const wdOutlineLevelBodyText = 10
Private Const wdListNumberStyleBullet = &H17
Private Const wdStyleListNumber = &HFFFFFFCE
Private Const wdStyleListNumber2 = &HFFFFFFC5
Private Const wdStyleListNumber3 = &HFFFFFFC4
Private Const wdStyleListNumber4 = &HFFFFFFC3
Private Const wdStyleListNumber5 = &HFFFFFFC2
Private Const wdStyleNormal = &HFFFFFFFF
Private Const wdBulletGallery = 1
Private Const wdAlignTabCenter = 1
Private Const wdAlignTabLeft = 0
Private Const wdTabLeaderSpaces = 0
Private Const wdStyleTypeParagraph = 1
Private Const wdAlignTabRight = 2

Private Const wdSectionBreakNextPage = 2
Private Const wdOrientPortrait = 0
Private Const wdOrientLandscape = 1
Private Const wdPasteMetafilePicture = 3
Private Const wdPasteEnhancedMetafile = 9
Private Const wdInLine = 0
Private Const wdLineSpace1pt5 = 1

Function GenerateWordStyle(theDocument As Object, WordObj As Object) As Boolean
    ' Sets up built-in numbered list styles and List Template
    ' including restart paragraph style
    ' Run in document template during design
    ' Macro created by Margaret Aldis, Syntagma
    '
    ' Create list starting style and format if it doesn't already exist
    FontSizeStandard = Range("FONT_SIZE_STD")
    
    Dim strStyleName As String, tmpName  As String
    strStyleName = "Heading 1" ' the style name in this set up
    Dim strListTemplateName As String
    strListTemplateName = "Proposal Template No. 192" ' the list template name in this set up
    Dim astyle As Object
        For Each astyle In theDocument.Styles
            If astyle.NameLocal = strStyleName Then GoTo Define 'already exists
        Next astyle
    ' doesn't exist
    theDocument.Styles.Add Name:=strStyleName, Type:=wdStyleTypeParagraph
Define:
    With theDocument.Styles(strStyleName)
        .AutomaticallyUpdate = False
        .BaseStyle = ""
        .NextParagraphStyle = wdStyleListNumber 'for international version compatibility
    End With
    With theDocument.Styles(strStyleName).ParagraphFormat
        .LineSpacingRule = wdLineSpaceSingle
        .WidowControl = False
        .KeepWithNext = True
        .KeepTogether = True
        .OutlineLevel = wdOutlineLevelBodyText
    End With
    ' Create the list template if it doesn't exist
    Dim aListTemplate As Object
        For Each aListTemplate In theDocument.ListTemplates
            If aListTemplate.Name = strListTemplateName Then GoTo Format 'already exists
        Next aListTemplate
    ' doesn't exist
        Dim newlisttemplate As Object
        Set newlisttemplate = theDocument.ListTemplates.Add(OutlineNumbered:=True, Name:="Proposal Template No. 192")
Format:
' Set up starter and three list levels - edit/extend from recorded details if required
    'Level 1
    With theDocument.ListTemplates(strListTemplateName).ListLevels(1)
        .NumberFormat = "%1."
        .TrailingCharacter = wdTrailingSpace
        .NumberStyle = wdListNumberStyleUppercaseRoman
        .NumberPosition = Excel.Application.CentimetersToPoints(0)
        .Alignment = wdListLevelAlignLeft
        .TextPosition = Excel.Application.CentimetersToPoints(0.76)
        .TabPosition = Excel.Application.CentimetersToPoints(0)
        .ResetOnHigher = True
        .StartAt = 1
        .LinkedStyle = strStyleName
    End With
    With theDocument.Styles(strStyleName)
        With .ParagraphFormat
            .LeftIndent = Excel.Application.CentimetersToPoints(0.76)
            .rightIndent = Excel.Application.CentimetersToPoints(0)
            .SpaceBefore = 12
            .SpaceAfter = 3
            .LineSpacingRule = wdLineSpaceSingle
            .Alignment = wdAlignParagraphJustify
            .KeepWithNext = True
            .PageBreakBefore = False
            .FirstLineIndent = Excel.Application.CentimetersToPoints(-0.76)
            .OutlineLevel = wdOutlineLevel1
        End With
        With .Font
            .Name = "Times New Roman"
            .Size = FontSizeStandard + 3
            .Bold = True
        End With
    End With

    ' Level 2
    With theDocument.ListTemplates(strListTemplateName).ListLevels(2)
        .NumberFormat = "%2."
        .TrailingCharacter = wdTrailingSpace
        .NumberStyle = wdListNumberStyleArabic
        .NumberPosition = Excel.Application.CentimetersToPoints(0)
        .Alignment = wdListLevelAlignLeft
        .TextPosition = Excel.Application.CentimetersToPoints(0.5)
        .TabPosition = Excel.Application.CentimetersToPoints(0.5)
        .ResetOnHigher = True
        .StartAt = 1
        .LinkedStyle = "Heading 2" 'theDocument.Styles(wdStyleListNumber).NameLocal
        tmpName = "Heading 2" 'theDocument.Styles(wdStyleListNumber).NameLocal
    End With
    With theDocument.Styles(tmpName)
        With .Font
            .Name = "Times New Roman"
            .Size = FontSizeStandard + 2
            .Bold = True
        End With
    End With
    
    With theDocument.ListTemplates(strListTemplateName).ListLevels(3)
        .NumberFormat = "%2.%3."
        .TrailingCharacter = wdTrailingSpace
        .NumberStyle = wdListNumberStyleArabic
        .NumberPosition = Excel.Application.CentimetersToPoints(0.5)
        .Alignment = wdListLevelAlignLeft
        .TextPosition = Excel.Application.CentimetersToPoints(1)
        .TabPosition = Excel.Application.CentimetersToPoints(1)
        .ResetOnHigher = True
        .StartAt = 1
        .LinkedStyle = "Heading 3" 'theDocument.Styles(wdStyleListNumber2).NameLocal
        tmpName = "Heading 3" 'theDocument.Styles(wdStyleListNumber2).NameLocal
    End With
    With theDocument.Styles(tmpName)
        With .Font
            .Name = "Times New Roman"
            .Size = FontSizeStandard + 1
            .Bold = True
        End With
    End With
    
    With theDocument.ListTemplates(strListTemplateName).ListLevels(4)
        .NumberFormat = "%4."
        .TrailingCharacter = wdTrailingSpace
        .NumberStyle = wdListNumberStyleLowercaseLetter
        .NumberPosition = Excel.Application.CentimetersToPoints(1)
        .Alignment = wdListLevelAlignLeft
        .TextPosition = Excel.Application.CentimetersToPoints(1.5)
        .TabPosition = Excel.Application.CentimetersToPoints(1.5)
        .ResetOnHigher = True
        .StartAt = 1
        .LinkedStyle = "Heading 4" 'theDocument.Styles(wdStyleListNumber3).NameLocal
        tmpName = "Heading 4" 'theDocument.Styles(wdStyleListNumber3).NameLocal
    End With
    With theDocument.Styles(tmpName)
        With .Font
            .Name = "Times New Roman"
            .Size = FontSizeStandard
            .Bold = True
            .Underline = True
        End With
    End With
    With theDocument.ListTemplates(strListTemplateName).ListLevels(5)
        .NumberFormat = "%5."
        .TrailingCharacter = wdTrailingSpace
        .NumberStyle = wdListNumberStyleLowercaseLetter
        .NumberPosition = Excel.Application.CentimetersToPoints(1)
        .Alignment = wdListLevelAlignLeft
        .TextPosition = Excel.Application.CentimetersToPoints(1.5)
        .TabPosition = Excel.Application.CentimetersToPoints(1.5)
        .ResetOnHigher = True
        .StartAt = 1
        .LinkedStyle = "Heading 5" 'theDocument.Styles(wdStyleListNumber4).NameLocal
        tmpName = "Heading 5" 'theDocument.Styles(wdStyleListNumber4).NameLocal
    End With
    With theDocument.Styles(tmpName)
        With .Font
            .Name = "Times New Roman"
            .Size = FontSizeStandard - 1
            .Italic = True
            .Bold = True
        End With
    End With
    With theDocument.ListTemplates(strListTemplateName).ListLevels(6)
        .NumberFormat = "%6."
        .TrailingCharacter = wdTrailingSpace
        .NumberStyle = wdListNumberStyleNumberInCircle
        .NumberPosition = Excel.Application.CentimetersToPoints(1)
        .Alignment = wdListLevelAlignLeft
        .TextPosition = Excel.Application.CentimetersToPoints(1.5)
        .TabPosition = Excel.Application.CentimetersToPoints(1.5)
        .ResetOnHigher = True
        .StartAt = 1
        With .Font
            .Bold = True
            .Size = FontSizeStandard - 2
        End With
        .LinkedStyle = "Heading 6" 'theDocument.Styles(wdStyleListNumber5).NameLocal
    End With
    With theDocument.ListTemplates(strListTemplateName).ListLevels(7)
        .NumberFormat = ""
        .LinkedStyle = ""
    End With
    With theDocument.ListTemplates(strListTemplateName).ListLevels(8)
        .NumberFormat = ""
        .LinkedStyle = ""
    End With
    With theDocument.ListTemplates(strListTemplateName).ListLevels(9)
        .NumberFormat = ""
        .LinkedStyle = ""
    End With
    
    '===Bullet & Normal
    With theDocument.Styles("Normal")
        With .ParagraphFormat
            .LeftIndent = Excel.Application.CentimetersToPoints(0)
            .rightIndent = Excel.Application.CentimetersToPoints(0)
            .SpaceBefore = 3
            .SpaceAfter = 3
            .LineSpacingRule = wdLineSpaceMultiple
            .LineSpacing = WordObj.Application.LinesToPoints(1.1)
            .Alignment = wdAlignParagraphJustify
            .FirstLineIndent = Excel.Application.CentimetersToPoints(1.27)
            .OutlineLevel = wdOutlineLevelBodyText
        End With
        .Font.Name = "Times New Roman"
        .Font.Size = FontSizeStandard
        .NoSpaceBetweenParagraphsOfSameStyle = False
        .AutomaticallyUpdate = False
        .BaseStyle = ""
        .NextParagraphStyle = "Normal"
    End With
           
    With theDocument
        If Not StyleExist(theDocument, "Title") Then .Styles.Add "Title"
        With .Styles("Title")
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard + 5
            .Font.Bold = True
            With .ParagraphFormat
                .FirstLineIndent = 0
                .Alignment = wdAlignParagraphCenter
            End With
        End With
        If Not StyleExist(theDocument, "NoFirstLine") Then .Styles.Add "NoFirstLine"
        With .Styles("NoFirstLine")
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard
            .Font.Bold = False
            With .ParagraphFormat
                .Alignment = wdAlignParagraphCenter
                .SpaceBefore = 3
                .SpaceAfter = 3
                .FirstLineIndent = 0
            End With
        End With
        If Not StyleExist(theDocument, "Diemnhan") Then .Styles.Add "Diemnhan"
        With .Styles("Diemnhan")
            With .ParagraphFormat
                .LeftIndent = WordObj.Application.CentimetersToPoints(1.6)
                .FirstLineIndent = WordObj.Application.CentimetersToPoints(-0.6)
            End With
            .NextParagraphStyle = wdStyleNormal 'for international version compatibility
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard
            .Font.Bold = True
        End With
        If Not StyleExist(theDocument, "Phuluc") Then .Styles.Add "Phuluc"
        With .Styles("Phuluc")
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard + 1
            .Font.Bold = True
            With .ParagraphFormat
                .Alignment = wdAlignParagraphLeft
                .LeftIndent = Excel.Application.CentimetersToPoints(0)
                .SpaceBeforeAuto = False
                .SpaceAfterAuto = False
                .FirstLineIndent = 0
            End With
        End With
        If Not StyleExist(theDocument, "Phuluc_sub") Then .Styles.Add "Phuluc_sub"
        With .Styles("Phuluc_sub")
            With .ParagraphFormat
                .LeftIndent = WordObj.Application.CentimetersToPoints(1.6)
                .FirstLineIndent = WordObj.Application.CentimetersToPoints(-0.6)
            End With
            .NextParagraphStyle = wdStyleNormal 'for international version compatibility
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard
            .Font.Bold = True
        End With
        
        If Not StyleExist(theDocument, "Caption") Then .Styles.Add "Caption"
        With .Styles("Caption")
            With .ParagraphFormat
                .LeftIndent = 0
                .FirstLineIndent = 0
                .Alignment = wdAlignParagraphCenter
            End With
            .NextParagraphStyle = wdStyleNormal 'for international version compatibility
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard
            .Font.Bold = True
        End With
        
        If Not StyleExist(theDocument, "Signature") Then .Styles.Add "Signature"
        With .Styles("Signature")
            With .ParagraphFormat
                .LeftIndent = WordObj.Application.CentimetersToPoints(1.6)
                .FirstLineIndent = WordObj.Application.CentimetersToPoints(-0.6)
                .Alignment = wdAlignParagraphRight
            End With
            .NextParagraphStyle = wdStyleNormal 'for international version compatibility
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard
            .Font.Bold = False
            .Font.Italic = True
        End With
        
        If Not StyleExist(theDocument, "Signer") Then .Styles.Add "Signer"
        With .Styles("Signer")
            With .ParagraphFormat
                ' Add tabs
                .TabStops.Add Position:=WordObj.Application.InchesToPoints(1.75), Alignment:=wdAlignTabCenter, Leader:=wdTabLeaderSpaces
                .TabStops.Add Position:=WordObj.Application.InchesToPoints(4.75), Alignment:=wdAlignTabCenter, Leader:=wdTabLeaderSpaces
                .SpaceBefore = 16
                .LineSpacingRule = wdLineSpace1pt5
                
                .LeftIndent = WordObj.Application.CentimetersToPoints(0)
                .FirstLineIndent = WordObj.Application.CentimetersToPoints(0)
                .Alignment = wdAlignParagraphLeft
            End With
            .NextParagraphStyle = wdStyleNormal 'for international version compatibility
            .Font.Name = "Times New Roman"
            .Font.Size = FontSizeStandard + 1
            .Font.Bold = True
        End With
        
        If Not StyleExist(theDocument, "FinancialItem") Then .Styles.Add "FinancialItem"
        With .Styles("FinancialItem")
            With .ParagraphFormat
                ' Add tabs
                .TabStops.Add Position:=WordObj.Application.InchesToPoints(6.31), Alignment:=wdAlignTabRight, Leader:=wdTabLeaderSpaces
            End With
            .NextParagraphStyle = wdStyleNormal 'for international version compatibility
        End With
    

        BulletText theDocument, "Diemnhan"
        BulletText theDocument, "Caption", "B" & ChrW(7843) & "ng %1 - ", wdListNumberStyleArabic
        
        ' add page number here
        .Sections(1).Footers(1).PageNumbers.Add PageNumberAlignment:=wdAlignPageNumberCenter, FirstPage:=True
    End With
    Exit Function
errHandler:
    WordObj.Quit
    GenerateWordStyle = True
End Function

Private Sub BulletText(sDoc As Object, LinkObj As String, Optional BulletStyle As String = "", Optional NumberStyle As Long)
    Dim myList As Object

    ' Add a new ListTemplate object
    Set myList = sDoc.ListTemplates.Add
    
    With myList.ListLevels(1)
        .Alignment = wdListLevelAlignLeft
        .ResetOnHigher = 0
        .StartAt = 1
        
        ' The following sets the font attributes of
        ' the "bullet" text
        .LinkedStyle = LinkObj
        If BulletStyle <> "" Then
            .TrailingCharacter = wdTrailingSpace
            .NumberPosition = 0
            .TextPosition = 0
            .NumberStyle = NumberStyle
            .NumberFormat = BulletStyle
        Else
            .TrailingCharacter = wdTrailingTab
            .NumberFormat = ChrW(183)
            .NumberPosition = Excel.Application.CentimetersToPoints(1)
            .TextPosition = Excel.Application.CentimetersToPoints(1.6)
            .TabPosition = Excel.Application.CentimetersToPoints(1.6)
            With .Font
                .Bold = False
                .Name = "Symbol" '"Wingdings"
                .Size = 13
            End With
        End If
    End With
End Sub

Private Function StyleExist(DocObj As Object, StlName As String) As Boolean
    Dim MyStl As Object, StlObjName As String
    On Error GoTo errHandler
    Set MyStl = DocObj.Styles(StlName)
    StlObjName = MyStl.NameLocal
    StyleExist = True
errHandler:
End Function
