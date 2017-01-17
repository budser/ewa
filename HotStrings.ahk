::-es::		; Edit the AutoHotKey script
Run C:\Program Files (x86)\Notepad++\notepad++.exe C:\Users\HP\Documents\Program Files\AutoHotkey.ahk
Return

::-ss::		; save and reload script but only if Notepad or Notepad++ is open and has focus
SetTitleMatchMode, 2
IfWinActive, Notepad ; any window with Notepad in title
{
	SendInput ^s
;	Sleep, 250
;	WinClose, Notepad
	Sleep, 250
	Reload, C:\Users\atalenfeld\Documents\My Program Files\AutoHotkey.ahk
}
Return

::-github::
Run https://github.com/budser/
Return

::-c:: ; Type "-c" in Chrome (browser) to go to the the cached version of almost any website.  This allows you to bypass advertisements, adblocker warnings, paywalls, and any number of other extraneous stuff (like javascript) that websites throw at you.
SleepTime := 250 ; Set the time to sleep between steps to .25 seconds

SendInput {Esc} ; In case "-c" hotstring typed in url bar, this restores the current URL in chrome
Sleep, %SleepTime%
SendInput ^l ; put focus on URL bar
Sleep, %SleepTime%
SendInput {Home} ; move to left of URL
Sleep, %SleepTime%
SendInput cache://{Enter} ; tell Chrome to show the cached version of page 
Return 

::-mortgage:: ; Show the corrected monthly mortgage (P&I + Tax + Insurance) on realtor.com

SetFormat, float, 0.2 ; Trims numbers to two decimal places

PI    := 0 ; Principle & Interest
Tax   := 0 ; Monthly tax from 2016
Ins   := 0 ; Estimated monthly Ins
Total := 0 ; Total monthly costs

SleepTime := 250 ; Set the time to sleep between steps to .25 seconds

SendInput ^f
Sleep, %SleepTime%
SendInput Principal & Interest
Sleep, %SleepTime%
SendInput {Enter}
Sleep, %SleepTime%
SendInput {Escape}
Sleep, %SleepTime%	
Send {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}
Sleep, %SleepTime%
SendInput ^c
Sleep, %SleepTime%
PI := RegExReplace(ClipBoard, "\D") ; remove non numeric characters from clipboard to find P&I
Sleep, %SleepTime%

SendInput ^f
Sleep, %SleepTime%
SendInput Home Insurance
Sleep, %SleepTime%
SendInput {Enter}
Sleep, %SleepTime%
SendInput {Escape}
Sleep, %SleepTime%	
Send {Shift Down}{Right}{Right}{Shift Up}
Sleep, %SleepTime%
SendInput ^c
Sleep, %SleepTime%
Ins := RegExReplace(ClipBoard, "\D") ; remove non numeric characters from clipboard to find estimated monthly insurance rate
Sleep, %SleepTime%

SendInput ^f
Sleep, %SleepTime%
SendInput Total Assessment
Sleep, %SleepTime%
SendInput {Enter}
Sleep, %SleepTime%
SendInput {Escape}
Sleep, %SleepTime%	
Send {Shift Down}{Down}{Down}{Shift Up}
Sleep, %SleepTime%
SendInput ^c
Sleep, %SleepTime%
StringTrimLeft, Tax, ClipBoard, 24 ; remove first 24 characters from clipboard to save monthly tax rate from 2016

Tax := RegExReplace(Tax, "\D") ; remove non numeric characters from value (for example, a comma)

Tax := Tax/12 ; Change annual tax to monthly

Sleep, %SleepTime%

Total := PI + Ins + Tax ; set Total to sum of costs

Clipboard := Total 

MsgBox, Monthly costs for this home: `n`nPrinciple & Intrest: $%PI%`nHome Insurance: $%Ins%`nMonthly Tax: $%Tax%`n`nTotal: $%Total%`n`n(Total has been copied to clipboard)

Return

::-wp::
::-rp::
Run www.whitepages.com/reverse_phone
Return 

::-gv::
Run https://www.google.com/voice/b/1#inbox
Return 


::-cc:: ; Correct Case - Capitalize the first letter of each word that is highlighted or left of the cursor and send to clipboard

SleepTime := 250 ; Set the time to sleep between steps to .25 seconds
ClipBoard := "" 
Sleep, %SleepTime%
SendInput ^c ; copy text in case already highlighted
Sleep, %SleepTime%
If (ClipBoard = "")	; True if no text was highlighted when hostring called. Highlight and copy text to the left of cursor
{
	SendInput {ShiftDown}{Home}{ShiftUp}
	SendInput ^c
}
Sleep, %SleepTime%
StringUpper, ClipBoard, ClipBoard, T ; "T" sets string to "title" format - first letter of each word capitalized
Return

::-w:: ; Look up the previous word or currently highlighted text in Wikipedia

SleepTime := 250 ; Set the time to sleep between steps to .25 seconds

ClipBoard := ""

SendInput ^c
Sleep, %SleepTime%

if(ClipBoard <> "")
{
ClipBoard := RegExReplace(ClipBoard, "[\W_]+")	; Remove non-letter, non-number, non-underscore
Run https://en.wikipedia.org/wiki/%ClipBoard%
}
else 
{
SendInput {Shift Down}{Ctrl Down}{Left}{Ctrl Up}{Shift Up}
Sleep, %SleepTime%

SendInput ^c
Sleep, %SleepTime%

ClipBoard := RegExReplace(ClipBoard, "[\W_]+")	; Remove non-letter, non-number, non-underscore
Sleep, %SleepTime%
Run https://en.wikipedia.org/wiki/%ClipBoard%

}
Return

::-d:: ; Look up the previous word (or highlighted text) on dictionary.com

SleepTime := 250 ; Set the time to sleep between steps to .25 seconds

ClipBoard := ""

SendInput ^c
Sleep, %SleepTime%

if(ClipBoard <> "")
{
	ClipBoard := RegExReplace(ClipBoard, "[\W_]+")	; Remove non-letter, non-number, non-underscore
	Run http://www.dictionary.com/browse/%ClipBoard%
}
else 
{
	SendInput {Shift Down}{Ctrl Down}{Left}{Ctrl Up}{Shift Up}
	Sleep, %SleepTime%

	SendInput ^c
	Sleep, %SleepTime%

	ClipBoard := RegExReplace(ClipBoard, "[\W_]+")	; Remove non-letter, non-number, non-underscore
	Sleep, %SleepTime%
	Run http://www.dictionary.com/browse/%ClipBoard%

}
Return 

::-s::
SendInput Sleep, `%SleepTime`%{Enter}{Enter} 
Return 

::-st::
SendInput SleepTime := 250 `; Set the time to sleep between steps to .25 seconds
Return 

::-fmsu::
WindowOpen := 0
SetTitleMatchMode, 2
Send {Volume_Up 111}
Run https://www.youtube.com/watch?v=sSLqeZzTU8I 
While (WindowOpen < 4)
{ 
	IfWinActive, YouTube
	{
		Sleep 2000 
		WindowOpen++
	} 
} 
Send f 

Return

::-listen::

SetTitleMatchMode, 2
IfWinExist, Start speech
{
	IfWinNotActive, Start speech
	{
		WinActivate, Start speech
	} 
}
Else
{
	Run C:\Users\HP\Documents\Program Files\Installation Files\Start speech recognition.lnk   
}

Return 

Return ; End of file

