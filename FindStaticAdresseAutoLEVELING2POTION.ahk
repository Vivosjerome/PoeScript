#SingleInstance Force
#Include, classMemory.ahk

; Enregistrement des options dans un fichier
SaveNewStaticAdress() {
    FileDelete, TEST.txt
    ; Utiliser un caractère spécial (par exemple, "`n") pour séparer les valeurs sur la même ligne
    FileAppend,%duree2%`n%dureeCouleur2%`n%duree3%`n%dureeCouleur3%`n%potion2%`n%couleur2%`n%potion3%`n%couleur3%, TEST.txt
}

LoadOptions() {
    FilePath := "TEST.txt"
    if (FileExist(FilePath)) {
        FileReadLine, duree2, %FilePath%, 1
        FileReadLine, dureeCouleur2, %FilePath%, 2
        FileReadLine, duree3, %FilePath%, 3
        FileReadLine, dureeCouleur3, %FilePath%, 4
        ; Lire les trois premières lignes
        FileReadLine, potion2, %FilePath%, 5
        FileReadLine, couleur2, %FilePath%, 6
        FileReadLine, potion3, %FilePath%, 7
        FileReadLine, couleur3, %FilePath%, 8

        
    }

    global X_Duree2
    global Y_Duree2
    
    global X_Duree3
    global Y_Duree3
    
    global X_Potion1
    global Y_Potion1

    global X_Potion2
    global Y_Potion2
    
    global X_Potion3
    global Y_Potion3

    ; Initialiser les coordonnées X et Y pour chaque potion
    CutePos(duree2)
    X_Duree2 := X
    Y_Duree2 := Y
    
    CutePos(duree3)
    X_Duree3 := X
    Y_Duree3 := Y
    
    CutePos(potion2)
    X_Potion2 := X
    Y_Potion2 := Y
    
    CutePos(potion3)
    X_Potion3 := X
    Y_Potion3 := Y
    
}

PotionPos(){

    ; Message box avec instructions
    MsgBox, Appuyez sur OK, puis deplacez votre souris successivement dans l'ordre des potions de gauche a droite sans compter la potion de vie qui est en position 1 . À chaque position, appuyez sur la touche Espace pour valider.

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    duree2 := X "," Y
    PixelGetColor, dureeCouleur2, %X%, %Y%

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    duree3 := X "," Y
    PixelGetColor, dureeCouleur3, %X%, %Y%

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    potion2 := X "," Y
    PixelGetColor, couleur2, %X%, %Y%

    ; Enregistrement et affichage de la position
    Input, _, L1
    MouseGetPos, X, Y
    potion3 := X "," Y
    PixelGetColor, couleur3, %X%, %Y%

    MsgBox, Position et couleur sauvegarde.

    ; Enregistrement des positions après les clics
    SaveNewStaticAdress()
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
