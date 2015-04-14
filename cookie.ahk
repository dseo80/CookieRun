#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance FORCE
Menu, tray, Icon, data\cookieicon.ico



Loop {

Run, adb -s 192.168.56.102:5555 shell input tap 380 100,,hide
Sleep 1000

Run, adb -s 192.168.56.102:5555 shell input tap 665 420,,hide

Sleep 4000

Run, adb -s 192.168.56.102:5555 shell input tap 665 420,,hide

Sleep 10000

Loop 250 {

Run, adb -s 192.168.56.102:5555 shell input tap 10 10,,hide
Sleep 1000

 }

;check for macro blocker before proceeding

;WinActivate BlueStacks App Player
;Sleep 200
;imagesearch, x1, y1, 600, 20, 750,150, *50 data\message.bmp
;if (ErrorLevel=0) {
; Run, adb -s 192.168.56.102:5555 shell input tap %x1% %y1%,,hide
;  Sleep 1000
; }
WinActivate BlueStacks App Player
Sleep 200
imagesearch, x1, y1, 350, 50, 700,250, *50 data\cardmatch.bmp
if (ErrorLevel=0) {
 CardMatch()
 }
WinActivate BlueStacks App Player
Sleep 200
imagesearch, x1, y1, 0, 0, 800, 480, *50 data\jellypick.bmp
if (ErrorLevel=0) {
   JellyPick()
   }
WinActivate BlueStacks App Player
Sleep 200   
imagesearch, x1, y1, 0, 0, 800, 480, *50 data\jumpingpick.bmp
if (ErrorLevel=0) {
   RestartCookie()
   }
WinActivate BlueStacks App Player
Sleep 200
imagesearch, x1, y1, 0, 0, 800, 480, *50 data\slidingpick.bmp
if (ErrorLevel=0) {
   RestartCookie()
   }

   
Sleep 3000
   
Run, adb -s 192.168.56.102:5555 shell input tap 365 450,,hide

Sleep 3000

Run, adb -s 192.168.56.102:5555 shell input tap 365 450,,hide

Sleep 3000

Run, adb -s 192.168.56.102:5555 shell input tap 365 450,,hide

Sleep 4000

}



;Functions

JellyPick() {
Loop {
Winactivate BlueStacks App Player
Sleep 200
imagesearch, x1, y1, 0, 0, 800, 480, *50 data\gomjelly.bmp
if (ErrorLevel=0) {
  Run, adb -s 192.168.56.102:5555 shell input tap %x1% %y1%,,hide
  Sleep 1000
} else {
return
}
}
}

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
  CardClick(3)
  CardClick(4)
  CardClick(5)
  CardClick(6)
  CardClick(1)
  CardClick(2)
  return
  }
  
CardClick(card) {
  Winactivate BlueStacks App Player
  if (card=1) {
     Run, adb -s 192.168.56.102:5555 shell input tap 243 153,,hide
    } else if (card=2) {
     Run, adb -s 192.168.56.102:5555 shell input tap 334 153,,hide
    } else if (card=3) {
     Run, adb -s 192.168.56.102:5555 shell input tap 530 153,,hide
    } else if (card=4) {
     Run, adb -s 192.168.56.102:5555 shell input tap 243 330,,hide
    } else if (card=5) {
     Run, adb -s 192.168.56.102:5555 shell input tap 334 330,,hide
    } else if (card=6) {
     Run, adb -s 192.168.56.102:5555 shell input tap 530 330,,hide
    }
    sleep 1000
    return
  }
  
  
  
  
RestartCookie() {
  Run, adb -s 192.168.56.102:5555 shell input keyevent 3,,hide
  sleep 5000
  Run, adb -s 192.168.56.102:5555 shell input tap 700 100,,hide
  sleep 2000
  Run, adb -s 192.168.56.102:5555 shell input tap 100 100,,hide
  sleep 20000
  Reload
  sleep 1000
  return
  }

F11::Present()

Present() {
Loop, 50 {
Run, adb -s 192.168.56.102:5555 shell input tap 530 350,,hide
Sleep 500
}

}

