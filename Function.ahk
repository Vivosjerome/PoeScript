#SingleInstance Force
#Include, classMemory.ahk

global X_Duree1
global Y_Duree1

global X_Duree2
global Y_Duree2

global X_Duree3
global Y_Duree3

global X_Duree4
global Y_Duree4

global X_Potion1
global Y_Potion1

global X_Potion2
global Y_Potion2

global X_Potion3
global Y_Potion3

global X_Potion4
global Y_Potion4

; Enregistrement des options dans un fichier
SavePotionSpeed() {
    FileDelete, potionSpeedConfig.txt
    ; Utiliser un caractère spécial (par exemple, "`n") pour séparer les valeurs sur la même ligne
    FileAppend,%duree1%`n%duree2%`n%duree3%`n%duree4%, potionSpeedConfig.txt
}

SaveSpeed(){
    ; Message box avec instructions
    MsgBox, Appuyez sur OK, puis deplacez votre souris vers le timer des potions dans l'ordre. `nappuyez sur la touche Espace pour valider.
    Loop, 4{

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    duree%A_Index% := X "," Y

    ; Enregistrement des positions après les clics
    SavePotionSpeed()

    }
    MsgBox, timer sauvegarde.
    
}


SavePotion1(){
    FileDelete, potion1.txt
    ; Utiliser un caractère spécial (par exemple, "`n") pour séparer les valeurs sur la même ligne
    FileAppend,%popo1%`n%couleur1%, potion1.txt
}

SavePotion2(){
    FileDelete, potion2.txt
    ; Utiliser un caractère spécial (par exemple, "`n") pour séparer les valeurs sur la même ligne
    FileAppend,%popo2%`n%couleur2%, potion2.txt
}

SavePotion3(){
    FileDelete, potion3.txt
    ; Utiliser un caractère spécial (par exemple, "`n") pour séparer les valeurs sur la même ligne
    FileAppend,%popo3%`n%couleur3%, potion3.txt
}

SavePotion4(){
    FileDelete, potion4.txt
    ; Utiliser un caractère spécial (par exemple, "`n") pour séparer les valeurs sur la même ligne
    FileAppend,%popo4%`n%couleur4%, potion4.txt
}


LoadOptions() {
    FilePath := "potionSpeedConfig.txt"
    if (FileExist(FilePath)) {
        FileReadLine, duree1, %FilePath%, 1
        FileReadLine, duree2, %FilePath%, 2
        FileReadLine, duree3, %FilePath%, 3
        FileReadLine, duree4, %FilePath%, 4  
    }

      ; Initialiser les coordonnées X et Y pour chaque potion
    CutePos(duree1)
    X_Duree1 := X
    Y_Duree1 := Y

    CutePos(duree2)
    X_Duree2 := X
    Y_Duree2 := Y

    CutePos(duree3)
    X_Duree3 := X
    Y_Duree3 := Y

    CutePos(duree4)
    X_Duree4 := X
    Y_Duree4 := Y

}

LoadPotion1() {
    FilePath := "potion1.txt"
    if (FileExist(FilePath)) {
        FileReadLine, popo1, %FilePath%, 1
        FileReadLine, couleur1, %FilePath%, 2
        ; Lire les trois premières lignes
    }

    CutePos(popo1)
    X_Potion1 := X
    Y_Potion1 := Y

}

LoadPotion2() {
    FilePath := "potion2.txt"
    if (FileExist(FilePath)) {
        FileReadLine, popo2, %FilePath%, 1
        FileReadLine, couleur2, %FilePath%, 2
        ; Lire les trois premières lignes
    }

    CutePos(popo2)
    X_Potion2 := X
    Y_Potion2 := Y

}

LoadPotion3() {
    FilePath := "potion3.txt"
    if (FileExist(FilePath)) {
        FileReadLine, popo3, %FilePath%, 1
        FileReadLine, couleur3, %FilePath%, 2
        ; Lire les trois premières lignes
    }

    CutePos(popo3)
    X_Potion3 := X
    Y_Potion3 := Y

}

;Supprime toutes les saves de potions
DeleteAllPotion(){
    FileDelete, potion1.txt
    FileDelete, potion2.txt
    FileDelete, potion3.txt
    FileDelete, potion4.txt

}

LoadPotion4() {
    FilePath := "potion4.txt"
    if (FileExist(FilePath)) {
        FileReadLine, popo4, %FilePath%, 1
        FileReadLine, couleur4, %FilePath%, 2
        ; Lire les trois premières lignes
    }

    CutePos(popo4)
    X_Potion4 := X
    Y_Potion4 := Y

}


Potion1(){

    ; Message box avec instructions
    MsgBox, Appuyez sur OK, puis deplacez votre souris SAUF la potion de vie qui est en position 1. `nappuyez sur la touche Espace pour valider.

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    popo1 := X "," Y
    PixelGetColor, couleur1, %X%, %Y%
    
    MsgBox, Potion sauvegarde.

    ; Enregistrement des positions après les clics
    SavePotion1()
}

Potion2(){

    ; Message box avec instructions
    MsgBox, Appuyez sur OK, puis deplacez votre souris SAUF la potion de vie qui est en position 1. `nappuyez sur la touche Espace pour valider.

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    popo2 := X "," Y
    PixelGetColor, couleur2, %X%, %Y%
    
    MsgBox, Potion sauvegarde.

    ; Enregistrement des positions après les clics
    SavePotion2()
}

Potion3(){

    ; Message box avec instructions
    MsgBox, Appuyez sur OK, puis deplacez votre souris SAUF la potion de vie qui est en position 1. `nappuyez sur la touche Espace pour valider.

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    popo3 := X "," Y
    PixelGetColor, couleur3, %X%, %Y%
    
    MsgBox, Potion sauvegarde.

    ; Enregistrement des positions après les clics
    SavePotion3()
}

Potion4(){

    ; Message box avec instructions
    MsgBox, Appuyez sur OK, puis deplacez votre souris SAUF la potion de vie qui est en position 1. `nappuyez sur la touche Espace pour valider.

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    popo4 := X "," Y
    PixelGetColor, couleur4, %X%, %Y%
    
    MsgBox, Potion sauvegarde.

    ; Enregistrement des positions après les clics
    SavePotion4()
}



takeLife(){
    Send, 1
    Sleep, 200

}

takeMana(){
    Send, 2
    Sleep, 200
}

GLOBAL X
GLOBAL Y
CutePos(potion) {
    ; Extraire les coordonnées X et Y de la potion
    Coord := StrSplit(potion, ",")
    X := Coord[1]
    Y := Coord[2]
}

Update(){
    #NoEnv
    SendMode, Input 
    SetWorkingDir %A_ScriptDir% ;set to script directory to see files

    ; below is the URL name you would like to download. Filename is the name of the filename
    url = https://github.com/Vivosjerome/PoeScript/archive/main.zip
    Filename = Update.zip

    FileReadLine, VNum, %A_WorkingDir%\version.txt, 1 ;looks for local version text and stores as vnum
    if ErrorLevel = 1
        Vnum = 0
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", "https://raw.githubusercontent.com/Vivosjerome/PoeScript/main/version.txt", true)
    whr.Send()
    ; Using 'true' above and the call below allows the script to remain responsive.
    whr.WaitForResponse() ;this is taken from the installer. Can also be located as an example on the urldownloadtofile page of the quick reference guide.
    version := whr.ResponseText
    MsgBox, 1, Appuyer OK pour telecharger, Version precedente %Vnum%`nNouvelle version %version%
    IfMsgBox OK
    UrlDownloadToFile, *0 %url%, %A_WorkingDir%\%Filename%
    if ErrorLevel = 1
        MsgBox, There was some error updating the file. You may have the latest version, or it is blocked.
    else if ErrorLevel = 0
        MsgBox, Mise a jour en cours. 
    else 
        MsgBox, some other crazy error occured. 

    ; Décompresse le fichier zip dans le dossier update
    RunWait, %ComSpec% /c powershell Expand-Archive -Path "%A_ScriptDir%\update.zip" -DestinationPath "%A_ScriptDir%\update", , Hide
    ; Supprime l'ancien fichier YourScript.exe s'il existe
    FileMove, %A_ScriptDir%\update\PoeScript-main\*, %A_ScriptDir%\, 1
    ; Supprime le fichier zip et le dossier update
    FileDelete, %A_ScriptDir%\update.zip
    FileRemoveDir, %A_ScriptDir%\update, 1
    MsgBox, Mise a jour terminé !
    Reload
    Return
}

CheckForUpdates() {
    #NoEnv
    SetWorkingDir %A_ScriptDir%

    ; URL du fichier de version sur GitHub
    versionURL := "https://raw.githubusercontent.com/Vivosjerome/PoeScript/main/version.txt"

    ; Lit la version actuelle localement
    FileReadLine, localVersion, %A_WorkingDir%\version.txt, 1
    if ErrorLevel = 1
        localVersion = 0

    ; Télécharge la version en ligne
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", versionURL, true)
    whr.Send()
    whr.WaitForResponse()
    onlineVersion := whr.ResponseText

    ; Convertion en Integer
    onlineVersion += 0
    onlineVersion := Round(onlineVersion, 1)
    localVersion += 0
    localVersion := Round(localVersion, 1)

    if (onlineVersion > localVersion) {
        ; Une mise à jour est disponible
        MsgBox, 1, Mise à jour, Une mise à jour est disponible. Voulez-vous mettre à jour maintenant?
        IfMsgBox Ok
        Update()
    }
}


Infos(){
    MsgBox, 0, Informations, 
    (LTrim
        CTRL + F9 : Sert a configurer les 4 timers des potions dans l'ordre 2, 3, 4, 5 `n
        CTRL + F2 : Sert a configurer la potion 2 `n
        CTRL + F2 : Sert a configurer la potion 3 `n
        CTRL + F2 : Sert a configurer la potion 4 `n
        CTRL + F2 : Sert a configurer la potion 5 `n
        CTRL + ALT + F10 : Sert a Supprimer toutes les configs des potions pas des timers `n
        XButton2 : Sert a mettre le script en pause

    )
}