Option Explicit
' This stuff will never change
Public Enum KeyinMode   ' Ch� cho ph?p c�p nh�t k? t� ��ng ki�u
    NumberType = 1      ' Ch� cho nh�p s�
    DateType = 2        ' Nh�p ki�u ng�y
    FormularType = 3    ' Ch� nh�p k? t� c�ng th�c
    NumberOnlyType = 4
    FreeType = 5
End Enum
Public Type LocaleSetting
    DecimalSeparator As String * 1
    GroupNumber As String * 1
    DateLocale As String * 10
End Type
Public Type FormArgument
    DataSource As String    ' Name of source range to be saved or loaded data from
    DataSetName As String   ' Name of object to be processed
    ReadOnly As Boolean     ' Define whether to lock the list
    SpecialNote As String   ' Special instruction needed
    WrapOutput As Boolean   ' Wrap output in bracket for attention
    NotAllowSelection As String ' Do not allow selection with those contained this string
    ModifyColumn As Boolean ' Tell the app to modify column data afterword
End Type
' Messages variable
Global SheetObjName As String
Global App_Title
Global ExternalLoad As Boolean
Global CurrentWorkBook As Workbook

Global AppLocale As LocaleSetting
Global ShapedLoaded As Boolean
Global frmObjectParameter As FormArgument
' for handling user event if there are any...
Global IndirectSetup As Boolean
Global AppStatus As Boolean
' for storing some temporary stuff
Global TempString As String
Global FontSizeStandard As Long
