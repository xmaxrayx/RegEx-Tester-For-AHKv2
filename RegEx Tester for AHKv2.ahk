#Requires AutoHotkey v2.0
#SingleInstance Force
;'"{`@xMaxrayx%n%:{code:Reborn}"'
;[Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 16:38:26  on 23/12/2023   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}

global appVersion := "0.0.1"
global appCodeName := "[Code : Re-Born]"
global appName := "RegexTester"
global appAuthor := " @xMaxrayx (before @unbreakable-ray)"
global appLicense := "AGPL3"

;aboutGui(appVersion,appAuthor,appName,appLicense, )
regexTesterMain()
 
regexTesterMain(text := "", regexText := "" ,textSize:= 10){
    ;====reformating parameters

    textSize := 's' textSize ' '
    

    ;====Gui build    

    regexTesterGUI := Gui()
    regexTesterGUI.Opt("AlwaysOnTop")
    regexTesterGUI.SetFont( textSize "cBlack")
    ;=====
    regexTesterGUI.Add("Text", "xm y15 w50" , "Regex :")
    regex_textbox := regexTesterGUI.add("Edit","yp w150")
    
    
    ;===
    regexTesterGUI.Add("Text", "  xm w50", "Text :")
    text_textbox := regexTesterGUI.add("Edit" , "yp w150 ")


    ;====
    regexTesterGUI.add("Text","h20 xm   w50" , "Result :")


    outputRegexText := regexTesterGUI.add("Text","h40 xm+60 yp w150" , "Nothing")
    outputRegexText.SetFont("cBlack")

    ;=====


    regexTesterGUI.Add("Button" , " yp50 xp15  " , "Copy Regex")
    aboutButton:= regexTesterGUI.Add("Button" , " yp x+15  " , "About")
    
    regexText := regex_textbox.Value
    

    ;==========events
    regex_textbox.OnEvent("Change" , (*)=> textChangeEvent(regex_textbox.Value , text_textbox.Value))
    text_textbox.OnEvent("Change" , (*)=> textChangeEvent(regex_textbox.Value , text_textbox.Value))
    aboutButton.OnEvent("Click" , (*)=> aboutGui(appVersion,appAuthor,appName,appLicense, ))

    textChangeEvent(regex , haystack){

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


  
    regexTesterGUI.Show()


}


aboutGui(version := "", author := "" , appName := "" , license := "" , licenseText := ""){

    ;"C:\Users\Max_Laptop\Programming\Github\xMaxrayx_Github\RegEx-Tester-For-AHKv2\Assists\about-picture.png"
    aboutGui := Gui()

    ;=====
    {
    aboutGui.Add("Picture", , A_ScriptDir . "\Assists\about-picture.png") 
    aboutGui.Add("Text", "yp w230 h45" , appName).SetFont("s30 cBlack", "Calibri")
    aboutGui.Add("Text", "h20 w230" , version "v").SetFont("s16 cBlack", "Calibri")
    aboutGui.Add("Text","h10" , "by: " author "`t" appCodeName "`nThe app under: " license " licenses")
    OkButton:= aboutGui.Add("Button","" , "OK")



    ;====events
    OkButton.OnEvent("click", (*)=>licenseGui("AGPL","s"))

    }
    aboutGui.Show()

}


licenseGui(licenseName , licensePath){
    licenseGui:= Gui()
    
        
}

