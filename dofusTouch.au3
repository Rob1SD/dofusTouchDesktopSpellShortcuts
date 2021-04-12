#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPIFiles.au3>
#include <Array.au3>
local $iniFile = @ScriptDir & "\setup.ini"
local $sort1  = IniRead($iniFile, "config", "sort1", "-1")
local $sort2  = IniRead($iniFile, "config", "sort2", "-1")
local $sort3  = IniRead($iniFile, "config", "sort3", "-1")
local $sort4  = IniRead($iniFile, "config", "sort4", "-1")
HotKeySet("{ESC}", "end")
HotKeySet("{F10}", "assingKey")
HotKeySet("a", "hotKeyFunc")
HotKeySet("z", "hotKeyFunc")
HotKeySet("e", "hotKeyFunc")
HotKeySet("r", "hotKeyFunc")
local $fenetre = GUICreate("dofusTouchScript",400, 400)
local $label1 = GUICtrlCreateLabel("sort1",50,50)
local $label2 = GUICtrlCreateLabel("sort2",50,100)
local $label3 = GUICtrlCreateLabel("sort3",50,150)
local $label4 = GUICtrlCreateLabel("sort4",50,200)
local $test1 = GUICtrlCreateButton("test", 250,40,100, 40)
local $test2 = GUICtrlCreateButton("test", 250,90,100, 40)
local $test3 = GUICtrlCreateButton("test", 250,140,100, 40)
local $test4 = GUICtrlCreateButton("test", 250,190,100, 40)
local $setup1 = GUICtrlCreateButton("setup", 150,40,100, 40)
local $setup2 = GUICtrlCreateButton("setup", 150,90,100, 40)
local $setup3 = GUICtrlCreateButton("setup", 150,140,100, 40)
local $setup4 = GUICtrlCreateButton("setup", 150,190,100, 40)
local $isSettingUp = false
 GUISetState(@SW_SHOW, $fenetre)
local $currentSettingUp = $sort1
 Local $iPID = 0
 local $idMsg = GUIGetMsg()
 local $pos = 0
 While ($idMsg <> $GUI_EVENT_CLOSE)
   If $idMsg = $test1 Then
	  move($sort1, true)
   EndIf
   If $idMsg = $test2 Then
	  move($sort2, true)
   EndIf
   If $idMsg = $test3 Then
	  move($sort3, true)
   EndIf
   If $idMsg = $test4 Then
	  move($sort4, true)
   EndIf
   If $idMsg = $setup1 Then
	  changeSelected("sort1")
   EndIf
   If $idMsg = $setup2 Then
	  changeSelected("sort2")
   EndIf
   If $idMsg = $setup3 Then
	  changeSelected("sort3")
   EndIf
   If $idMsg = $setup4 Then
	  changeSelected("sort4")
   EndIf
  $idMsg = GUIGetMsg()
WEnd

func changeSelected($selected)
   debug($selected)
   $currentSettingUp = $selected
   $isSettingUp = True
EndFunc
func debug($str)
   ConsoleWrite($str & @CRLF)
EndFunc

func assingKey()
   debug($currentSettingUp)
   if $isSettingUp = False then
	  Return
   EndIf
   $isSettingUp = False
   local $curr = MouseGetPos()
   Assign($currentSettingUp, $curr[0] & " " & $curr[1])
;~    debug(eval($currentSettingUp)[0])
   Switch $currentSettingUp

   case "sort1"
	  IniWrite($iniFile,"config","sort1",eval($currentSettingUp))
   case "sort2"
	  IniWrite($iniFile,"config","sort2",eval($currentSettingUp))
   case "sort3"
	  IniWrite($iniFile,"config","sort3",eval($currentSettingUp))
   case "sort4"
	  IniWrite($iniFile,"config","sort4",eval($currentSettingUp))

   EndSwitch

EndFunc
func move($spell, $test = false)
   if $spell = -1 Then
	  Return
   endif

   local $pos = StringSplit($spell, " ")
   local $currentPos = MouseGetPos()

   if $test = true Then
	  MouseMove($pos[1], $pos[2])
	  Return
   EndIf

   MouseMove($pos[1], $pos[2], 0)
   MouseClick($MOUSE_CLICK_LEFT)
   MouseMove($currentPos[0], $currentPos[1], 0)

EndFunc

func hotKeyFunc()
   Switch @HotKeyPressed
        Case "a"
            move($sort1)
        Case "z"
            move($sort2)
		 Case "e"
			move($sort3)
        Case "r"
            move($sort4)
    EndSwitch
EndFunc

func end()
   exit
EndFunc