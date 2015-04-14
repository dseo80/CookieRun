#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance FORCE
Menu, tray, Icon, data\cookieicon.ico

/*Variables*/

;Define the emulator here for genymotion
global emulator := "192.168.56.102:5555"
;global emulator := "emulator-5554"

;Needed for Bluestacks Functionality where window name cannot be found with above
global emulatorwin := "192.168.56.102"
;global emulatorwin :="BlueStacks App Player"

/*Main Loop*/

;0th Level Loop function starts here
Loop {

;Press Start
	Run, adb -s %emulator% shell input tap 665 420,,hide
	Sleep 4000

;Press Start
	Run, adb -s %emulator% shell input tap 665 420,,hide
	Sleep 10000

;1st Level Loop for jumping while ingame, note loop number will determine game length
	Loop 250 {
		Run, adb -s %emulator% shell input tap 10 10,,hide
		Sleep 1000
		} ;end of 1st level loop

;Game will end after above loop		
;Check for macro blocker before proceeding

;Pick Same Card Macro Blocker
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 350, 50, 700,250, *50 data\cardmatch.bmp
	if (ErrorLevel=0) {
	CardMatch()
	Sleep 2000
	}
;Pick Jelly Card
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\jellypick.bmp
	if (ErrorLevel=0) {
	JellyPick()
	Sleep 2000
	}
;Pick Jumping or Sliding Card - will restart the game	
	WinActivate %emulatorwin%
	Sleep 200   
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\jumpingpick.bmp
	if (ErrorLevel=0) {
	RestartCookie()
	Sleep 2000 ;This line wont execute due to reload in above function
	}
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\slidingpick.bmp
	if (ErrorLevel=0) {
	RestartCookie()
	Sleep 2000 ;This line wont execute due to reload in above function
	}
;Pause 5 seconds after macro checker
	Sleep 5000
   

;We should be at aftergame screen now
;Press OK
	Run, adb -s %emulator% shell input tap 365 450,,hide
	Sleep 3000

;Now we either have a box(es) or no boxes

;Run, adb -s %emulator% shell input tap 365 450,,hide
;Sleep 3000
;Run, adb -s %emulator% shell input tap 365 450,,hide
;Sleep 4000

;end of 0th level loop
}

/*Hotkeys*/

F11::Present()


/*Functions*/

;Picks the gomjelly by imagesearch looping
JellyPick() {
Loop {
WinActivate %emulatorwin%
Sleep 200
imagesearch, x1, y1, 0, 0, 800, 480, *50 data\gomjelly.bmp
if (ErrorLevel=0) {
  Run, adb -s %emulator% shell input tap %x1% %y1%,,hide
  Sleep 1000
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
    sleep 1000
    return
  }

CardBackClick()  {
	Loop {
	WinActivate %emulatorwin%
	Sleep 200
	imagesearch, x1, y1, 0, 0, 800, 480, *50 data\cardback.bmp
	if (ErrorLevel=0) {
	Run, adb -s %emulator% shell input tap %x1% %y1%,,hide
	Sleep 1000
	}
 	else {
	return
	}
	}
}
  
;restarts cookierun  
RestartCookie() {
;send homekey event
  Run, adb -s %emulator% shell input keyevent 3,,hide
  sleep 5000
;click task killer
  Run, adb -s %emulator% shell input tap 700 100,,hide
  sleep 2000
;click cookierun
  Run, adb -s %emulator% shell input tap 100 100,,hide
  sleep 20000
;reloads script
  Reload
;this stuff doesnt get executed due to reload
  sleep 1000
  return
}

;Open some presents
Present() {
	Loop, 50 {
		Run, adb -s %emulator% shell input tap 530 350,,hide
		Sleep 500
		}
}

