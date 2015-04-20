#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode,2
#SingleInstance FORCE
Menu, tray, Icon, data\cookieicon.ico

/*
TODOS
1. reduce sizes of imagesearch boxes to minimum sizes
2. find out why disconnects occur and if its preventable
3. corner case fixes
a. on leveling up, 
b. accidental presses (press friend, press cookie, press pet - x?),
c. midnight,
d. messageses
*/


/*
Define Variables Here
*/

;Define the emulator here for genymotion
;global emulator := "192.168.56.102:5555"
global emulator := "emulator-5554"

;Needed for Bluestacks Functionality where window name cannot be found with above
;global emulatorwin := "192.168.56.102"
global emulatorwin :="BlueStacks App Player"

/*
Main Loop Starts Here
*/

;0th Level Loop function starts here
Loop {

;Check for macro blocker before proceeding
;Pick Same Card Macro Blocker
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 350, 50, 700,250, *50 data\cardmatch.bmp
	if (ErrorLevel=0) {
	CardMatch()
	Sleep 5000
	}
;Pick Jelly Card
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\jellypick.bmp
	if (ErrorLevel=0) {
	JellyPick()
	Sleep 5000
	}
;Pick Jumping or Sliding Card - will restart the game	
	WinActivate %emulatorwin%
	Sleep 200   
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\jumpingpick.bmp
	if (ErrorLevel=0) {
	RestartCookie()
	Sleep 5000 ;This line wont execute due to reload in above function
	}
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\slidingpick.bmp
	if (ErrorLevel=0) {
	RestartCookie()
	Sleep 5000 ;This line wont execute due to reload in above function
	}
   

;We should be at aftergame screen now
;Press OK
	Sleep 8000
	Run, adb -s %emulator% shell input tap 365 450,,hide
	Sleep 8000

;Now we either have a box(es) or no boxes
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\haveboxes.bmp
	if (ErrorLevel=0) {
	OpenBoxes()
	}

;Press Start
	Sleep 20000
	Run, adb -s %emulator% shell input tap 665 420,,hide
	Sleep 5000

;Press Start
	Run, adb -s %emulator% shell input tap 665 420,,hide
	Sleep 10000

;1st Level Loop for jumping while ingame, note loop number will determine game length
	Loop 240 {
		Run, adb -s %emulator% shell input tap 10 10,,hide
		Sleep 1000
		} ;end of 1st level loop

;Game will end after above loop		


;end of 0th level loop
}

/*
Main Loop Ends Here
*/

/*
Define Hotkeys
*/

F11::ClickMulti()

/*
Define Functions
*/

;Picks the gomjelly by imagesearch looping
JellyPick() {
Loop {
WinActivate %emulatorwin%
Sleep 200
imagesearch, x1, y1, 0, 0, 800, 480, *50 data\gomjelly.bmp
if (ErrorLevel=0) {
  Run, adb -s %emulator% shell input tap %x1% %y1%,,hide
  Sleep 1500
} else {
return
}
}
}

;Picks all possible combinations to cardmatch (may need to fix overclicking in case cards are matched earlier)
CardMatch() {
  CardClick(1)
  CardClick(2)
  CardClick(1)
  CardClick(4)
  CardClick(1)
  CardClick(5)
  CardClick(1)
  CardClick(6)
  CardClick(2)
  CardClick(4)
  CardClick(2)
  CardClick(5)
  CardClick(2)
  CardClick(6)
  CardClick(4)
  CardClick(5)
  CardClick(4)
  CardClick(6)
  CardClick(5)
  CardClick(6)
;now only card 3 and one other card remain
  CardClick(3) ;flip over card 3
  CardBackClick() ;imgsearch for backside image and click it
  return
  }

;helper functions for above  
CardClick(card) {
	WinActivate %emulatorwin%
	if (card=1) {
     Run, adb -s %emulator% shell input tap 243 153,,hide
    } else if (card=2) {
     Run, adb -s %emulator% shell input tap 334 153,,hide
    } else if (card=3) {
     Run, adb -s %emulator% shell input tap 530 153,,hide
    } else if (card=4) {
     Run, adb -s %emulator% shell input tap 243 330,,hide
    } else if (card=5) {
     Run, adb -s %emulator% shell input tap 334 330,,hide
    } else if (card=6) {
     Run, adb -s %emulator% shell input tap 530 330,,hide
    }
    sleep 1500
    return
  }

CardBackClick()  {
	Loop {
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\cardback.bmp
	if (ErrorLevel=0) {
	Run, adb -s %emulator% shell input tap %x1% %y1%,,hide
	Sleep 1500
	}
 	else {
	return
	}
	}
}

OpenBoxes() {
Run, adb -s %emulator% shell input tap 365 450,,hide
Sleep 8000
Run, adb -s %emulator% shell input tap 365 450,,hide
Sleep 8000
return
}

;restarts cookierun  
RestartCookie() {
;send homekey event
  Run, adb -s %emulator% shell input keyevent 3,,hide
  sleep 5000
;click task killer
  Run, adb -s %emulator% shell input tap 700 100,,hide
  sleep 3000
;click cookierun
  Run, adb -s %emulator% shell input tap 100 100,,hide
  sleep 60000
;Press Start (incase macro is removed after restart)
  Sleep 20000
  Run, adb -s %emulator% shell input tap 665 420,,hide
  Sleep 5000
;Press Start (incase macro is removed after restart)
  Run, adb -s %emulator% shell input tap 665 420,,hide
  Sleep 10000
;reloads script
  Reload
;this stuff doesnt get executed due to reload
  sleep 1000
  return
}

;Click 50 times
ClickMulti() {
	Loop, 50 {
		Click
		Sleep 500
		}
}

