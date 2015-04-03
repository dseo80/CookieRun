imagesearch, x1, y1, 0, 0, 800, 480, *50 cardmatch.bmp
if (ErrorLevel=0) {
 CardMatch()
 else {
  imagesearch, x1, y1, 0, 0, 800, 480, *50 jellypick.bmp
   if (ErrorLevel=0) {
   JellyPick()
   }
   }
   }
return

JellyPick() {
Loop, 6 {
 imagesearch, x1, y1, 0, 0, 800, 480, *50 gomgelly.bmp
 if (ErrorLevel=0) {
  *input tap %x1% %y1%
  sleep 500
  } else {
  return}
  }
  }

CardMatch() {
  CardClick(1)
  CardClick(2)
  CardClick(1)
  CardClick(3)
  CardClick(1)
  CardClick(4)
  CardClick(1)
  CardClick(5)
  CardClick(1)
  CardClick(6)
  CardClick(2)
  CardClick(3)
  CardClick(2)
  CardClick(4)
  CardClick(2)
  CardClick(5)
  CardClick(2)
  CardClick(6)
  CardClick(3)
  CardClick(4)
  CardClick(3)
  CardClick(5)
  CardClick(3)
  CardClick(6)
  CardClick(4)
  CardClick(5)
  CardClick(4)
  CardClick(6)
  CardClick(5)
  CardClick(6)
  return
  }
  
  CardClick(card) {
  if (card=1) {
    *input tap 243 153
    } else if (card=2) {
    *input tap 334 153
    } else if (card=3) {
    *input tap 430 153
    } else if (card=4) {
    *input tap 243 250
    } else if (card=5) {
    *input tap 334 250
    } else if (card=6) {
    *input tap 430 250
    }
    sleep 500
    return
  }
  
  
