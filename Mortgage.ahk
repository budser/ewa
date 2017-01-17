
::-mortgage::

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
