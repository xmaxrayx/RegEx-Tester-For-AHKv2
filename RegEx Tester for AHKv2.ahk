#Requires AutoHotkey v2.0
#SingleInstance Force

;[Laptop HQ] @xMaxrayx @Unbreakable-ray [Code : ReBorn]   at 16:38:26  on 23/12/2023   (24H Format)  (UTC +2) 	 {Can we prove we are stronger than before?}

global appVersion := "0.0.1"
global appCodeName := "[Code : Re-Born]"
global appName := "RegexTester"
global appAuthor := "@xMaxrayx (before @unbreakable-ray)"
global appLicense := "AGPL3"

aboutGui(appVersion,appAuthor,appName,appLicense, )
;regexTesterMain()
 
regexTesterMain(text := "", regexText := ""){

    
    regexTesterGUI := Gui()

    ;=====
    regexTesterGUI.Add("Text", "xm y15 w50" , "Regex :")
    regex_textbox := regexTesterGUI.add("Edit","yp w150")
    
    
    ;===
    regexTesterGUI.Add("Text", "  xm w50", "Text :")
    text_textbox := regexTesterGUI.add("Edit" , "yp w150 ")


    ;====
    regexTesterGUI.add("Text","h20 xm   w50" , "Result :")


    outputRegexText := regexTesterGUI.add("Text","h40 xm+60 yp w150" , "Nothing")
    outputRegexText.SetFont("s8 cBlack")

    ;=====


    regexTesterGUI.Add("Button" , " yp50 xp15  " , "Copy Regex")
    regexTesterGUI.Add("Button" , " yp x+15  " , "About")
    
    regexText := regex_textbox.Value
    
    regex_textbox.OnEvent("Change" , (*)=> textChangeEvent(regex_textbox.Value , text_textbox.Value))
    text_textbox.OnEvent("Change" , (*)=> textChangeEvent(regex_textbox.Value , text_textbox.Value))


    textChangeEvent(regex , haystack){

        try {

            if  RegExMatch( haystack  ,regex) == 0{
                outputRegexText.Value := "Not found"
                outputRegexText.SetFont("s8 cRed")
            }
            else if (haystack == "")&& (regex == "") {
                outputRegexText.Value := "Empty"
                outputRegexText.SetFont("s8 cBlack")
                
            }
            else{

                outputRegexText.Value := "Found at : [" . RegExMatch( haystack  ,regex) . "]" 
                outputRegexText.SetFont("s8 cGreen")

            }
            



        } catch Error as regexError {
            outputRegexText.Value := "Error: {" . regexError.Message . "}" 
            outputRegexText.SetFont("s8 cRed")
            


        }
        
    }



    regexTesterGUI.Show()


}


aboutGui(version := "", author := "" , appName := "" , license := "" , licenseText := ""){

    ;"C:\Users\Max_Laptop\Programming\Github\xMaxrayx_Github\RegEx-Tester-For-AHKv2\Assists\about-picture.png"
    aboutGui := Gui()

    ;=====
    aboutGui.Add("Picture", , A_ScriptDir . "\Assists\about-picture.png") 
    aboutGui.Add("Text", "yp w230 h40" , appName).SetFont("s24 cBlack", "Calibri")
    aboutGui.Add("Text", , "Version :" version "`t" appCodeName).SetFont("s12 cBlack", "Calibri")
    aboutGui.Add("Text", , "by: " author)
    aboutGui.Add("Text",  , appName "`nVersion :" version "under" license )
    aboutGui.Show()


}