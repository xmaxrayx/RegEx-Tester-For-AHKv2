#Requires AutoHotkey v2.0
#SingleInstance Force
;'"{`@xMaxrayx%n%:{code:Reborn}"'
;[Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 16:38:26  on 23/12/2023   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}

global appVersion := "0.0.1"
global appCodeName := "[Code : Re-Born]"
global appName := "RegexTester"
global appAuthor := " @xMaxrayx (before @unbreakable-ray)"
global appLicense := "AGPLv3"

;================this section for winactive

global mainWindowActive := 0
global mainWindow_Ahk_ID := 0

;====================

;app settings=============================

#HotIf  WinActive("ahk_id " mainWindow_Ahk_ID) ;&& (mainWindowActive == 1) ;sometimes it breaks ;?; 
;==========================================

F1::{
    aboutGui("ss",appVersion,appAuthor,appName,appLicense, )   
}



;aboutGui(appVersion,appAuthor,appName,appLicense, )
regexTesterMain("","",)
 



regexTesterMain(text := "", regexText? ,textSize:= 10  ,copyClose:= 0 ,textBoxWidth := 500, regexHight := 25 , textHight := 25){
    ;this is normal lounch gui
    
    ;======for winactive
    global mainWindowActive := 1
    




    ;====reformating parameters
    
    textSize := 's' textSize ' '
    

    ;====Gui build    




    mainGUI := Gui("+LastFound AlwaysOnTop","RegexTester")
    ;mainGUI.Opt("+LastFound AlwaysOnTop")
    mainGUI.SetFont( textSize "cBlack")
    
    ;=============
    ;========================================
    ; we need it for doufoult cursur placment,this may sounds useless but wee need it     ;ok dont read this--->(removed maybe i will do smt about it in future)
    ;=========
    if (IsSet(regexText)) && (regexText !="") {  ;need the second one becouse ahk think "" is a value
        ;need fix ;?
        ;MsgBox 'have a value'
               
        
        
        ;===
        mainGUI.Add("Text", "x10 y50  w50", "Text :")
        Haystack_textBox := mainGUI.add("Edit" , "yp w" textBoxWidth " h" regexHight)
        ;===    
        mainGUI.Add("Text", "x10 y15  w50" , "Regex :")
        Regex_textBox := mainGUI.add("Edit","yp w" textBoxWidth " h" regexHight)
        

     }
     else{
        ;MsgBox 'No setted'
       
        mainGUI.Add("Text", "xm y15 w50" , "Regex :")
        Regex_textBox := mainGUI.add("Edit","yp w" textBoxWidth " h" regexHight)
        
        ;===
        mainGUI.Add("Text", "  xm w50", "Text :")
        Haystack_textBox := mainGUI.add("Edit" , "yp w" textBoxWidth " h" regexHight)

        regexText := "" ;need this to fix the bug for not having value
       
     }
    
    
    
    
    
    ;=====


    ;====
    mainGUI.add("Text","h20 xm   w50" , "Result :")


    outputRegexText := mainGUI.add("Text","h40 xm+60 yp w" textBoxWidth , "Nothing")
    outputRegexText.SetFont("cBlack")

    ;=====
    local copyRegexButtonXLocation :=  ((textBoxWidth -50) / 2)

   ;removed ; copyButton := regexTesterGUI.Add("Button" , " yp50 x" copyRegexButtonXLocation , "Copy Regex") ;xp15
    if copyClose := 1 { 
    copyButton := mainGUI.Add("Button" , " yp50 x" copyRegexButtonXLocation , "&Copy regex and close")    
    }else{
        copyButton := mainGUI.Add("Button" , " yp50 x" copyRegexButtonXLocation , "&Copy Regex")
    }
    
    
    mainGUI.Add("Button" , "x10 yp" , "Cheat Code")
    
    aboutButton:= mainGUI.Add("Button" , " yp x520 " , "About")


    

     ;===========================================================
    ;===========================================================

    ;this is for text orgnaztion since windows is bad
    Regex_textBox.Text := regexText
    Haystack_textBox.Text := text




    ;================================
    regexText := Regex_textBox.Value

    ;===========================================================
    ;==========events===========================================
    Regex_textBox.OnEvent("Change" , (*)=> textChangeEvent(Regex_textBox.Value , Haystack_textBox.Value))
    Haystack_textBox.OnEvent("Change" , (*)=> textChangeEvent(Regex_textBox.Value , Haystack_textBox.Value))
    aboutButton.OnEvent("Click" , (*)=> aboutGui(appName,appVersion,appAuthor,appName,appLicense, ))
    copyButton.OnEvent("Click" , (*)=> copyClose_math(Regex_textBox.Value,copyClose))
                                        
                                       
    
   



    ;=======================================================
    copyClose_math(text, mode){
        if mode == 0{
            A_Clipboard := text

        }else if mode == 1 {
            A_Clipboard := text
            mainGUI.Destroy()
        }else if mode == 2 {
            A_Clipboard := text
            mainGUI.Hide()
            
        }else{ ; if there was a  bug
            A_Clipboard := text
        }
    }


    textChangeEvent(regex , haystack){
    ;this is for auto size

        ;ok ahk dont suupport dynamic size gui so i removed this next line
        ;global textBoxWidth := 9999




    ;this is for regix 
        try {

            if  RegExMatch( haystack  ,regex) == 0{
                outputRegexText.Value := "Not found"
                outputRegexText.SetFont("cRed")
            }
            else if (haystack == "")&& (regex == "") {
                outputRegexText.Value := "Empty"
                outputRegexText.SetFont("cBlack")
                
            }
            else{

                outputRegexText.Value := "Found at : [" . RegExMatch( haystack  ,regex) . "]" 
                outputRegexText.SetFont("cGreen")

            }
            


        } catch Error as regexError {
            outputRegexText.Value := "Error: {" . regexError.Message . "}" 
            outputRegexText.SetFont("cRed")
           
        }
        
    }
     


  
    mainGUI.Show()
    
    ;===for new future


    



    global mainWindow_Ahk_ID := WinGetIDLast("A")
    ;MsgBox mainWindow_Ahk_ID
    
    GuiClose:
    ;MsgBox 'bey bey'x`x
    ;cleareing the var for more to free some ram
    global mainWindowActive := 0
    ;global mainWindow_Ahk_ID := 0
    
}








aboutGui(title := A_ScriptName ,version := "", author := "" , appName := "" , license := "" , licenseText := "" , separateButton := 0 ,licensePath:= A_ScriptDir . "\LICENSE" , fullPictureMode:= 0 ,picture := A_ScriptDir . "\Assists\about-picture.png" ,pr := 1){

    ;"C:\Users\Max_Laptop\Programming\Github\xMaxrayx_Github\RegEx-Tester-For-AHKv2\Assists\about-picture.png"
    aboutGui := Gui("AlwaysOnTop", "About: " appName)

    ;=====
    {
    if fullPictureMode == 1{

        aboutGui.Add("Picture", , picture) 
    }
    else{
        
        screenWidth := 1200 ;A_ScreenWidth
        screenHeight := 1200 ;A_ScreenHeight
        pictureFile := getImageSize(picture)
        
        pictureRatio := pictureFile.width / pictureFile.height
        screenRatio := screenWidth / screenHeight
        
       pr := 1

        Def_Percent := (pictureRatio/screenRatio) *100
        
        ; pictureHight := (Def_Percent * pr * pictureFile.height) /100
        ; pictureWidth := (Def_Percent * pr * pictureFile.width ) /100
        
        pictureHight := ((Def_Percent  * pictureFile.height)/100  )
        pictureWidth := (( Def_Percent  * pictureFile.width)/100 )






        ;===fix over hight above the screen
        ; if pictureHight > A_ScreenHeight{
        ;     pictureHight := A_ScreenHeight
        ; }



        getImageSize(imagePath){   ;this func under mit lincess ;https://github.com/Masonjar13/AHK-Library
            splitPath imagePath,&fN,&fD
        
            oS:=ComObject("Shell.Application")
            oF:=oS.namespace(fD?fD:a_workingDir)
            oFn:=oF.parseName(fD?fN:imagePath)
            size:=strSplit(oFn.extendedProperty("Dimensions"),"x"," ?" chr(8234) chr(8236))
        
            return {width: size[1],height: size[2]}
        }






        aboutGui.Add("Picture",'H' pictureHight ' W' pictureWidth, picture) 

        }
    aboutGui.Add("Text", "yp w230 h45" , appName).SetFont("s30 cBlack", "Calibri")
    aboutGui.Add("Text", "h20 w230" , version "v").SetFont("s16 cBlack", "Calibri")
    aboutGui.Add("Text","h10" , "by: " author "`t" appCodeName "`nThe app under: " license " licenses")
    
    if separateButton == 1{
        OkButton:= aboutGui.Add("Button","xp100 yp100" , "Read the licenses")
        OkButton.OnEvent("click", (*)=>licenseGui(appLicense , A_ScriptDir . "\LICENSE"))
        
    }
    else{
        aboutGui.Add("Edit", "xp h450 +ReadOnly w400" , licenseMath() )
        okButton := aboutGui.Add("Button","w60 xp+180 y+20  h30 Default","&Ok") ;;.SetFont("s15") ;this couse trouple err
        OkButton.OnEvent("click", (*)=>aboutGui.Destroy())
        licenseMath(){
            try {
                return FileRead(licensePath)
            } catch Error {
                return "Error: didn't found the file`nsee the license on gnu.org`nhttps://www.gnu.org/licenses/agpl-3.0.html" 
            }
    }
}




    ;====events
  

    }
    aboutGui.Show()

}






licenseGui(licenseName , licensePath ,fontSize := 8){
    licenseGui:= Gui("AlwaysOnTop")
    licenseGui.Add("Text","x150 y10 h40 w100", licenseName).SetFont("s" (fontSize + 10))
    
    licenseGui.Add("Edit", "x20 y60 h450 +ReadOnly w400" , licenseMath() )
    licenseGui.Show()
      
    
    licenseMath(){
        try {
            return FileRead(licensePath)
        } catch Error {
            return "Error: didn't found the file`nsee the license on gnu.org`nhttps://www.gnu.org/licenses/agpl-3.0.html" 
        }
    }
}



LengthTextBOX_Math(count,sizeMOD ,lowReturn){
    if count == 0 {
        return lowReturn
    }
    else if  (count * sizeMOD) < lowReturn {
     return lowReturn
    }
    else{
    return (count * sizeMOD)
    }

}

