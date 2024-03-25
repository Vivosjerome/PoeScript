#Include, classMemory.ahk

; Définir les pourcentages seuils pour la vie et le mana
pourcentage_seuil_vie := 50
pourcentage_seuil_mana := 30

global staticAdress := 0x2DF0E20
global staticAdressReservation := 0x30575A8
global manaSave
global duree1
global duree2
global duree3
global duree4
global dureeCouleur1
global dureeCouleur2
global dureeCouleur3
global dureeCouleur4
global potion1
global potion2
global potion3
global potion4
global couleur1
global couleur2
global couleur3
global couleur4

staticOffsetAll := [0x0, 0x130, 0x240, 0x8, 0x10, 0x20]

manaMaxOffset := 0x1F4

manaOffset := 0x1F8

lifeMaxOffset := 0x1A4

lifeOffset := 0x1A8
CheckForUpdates()
LoadOptions()

Loop{

    mem := new _ClassMemory("ahk_exe PathOfExileSteam.exe", "", hProcessCopy) 
    if !isObject(mem)
        msgbox Erreur ouverture du handle
    if !hProcessCopy
        msgbox Erreur ouverture du. Error Code = %hProcessCopy%
        
    PixelGetColor, popo1, X_Potion1, Y_Potion1
    PixelGetColor, popo2, X_Potion2, Y_Potion2
    PixelGetColor, popo3, X_Potion3, Y_Potion3
    PixelGetColor, popo4, X_Potion4, Y_Potion4

    PixelGetColor, duree1, X_Duree1, Y_Duree1
    PixelGetColor, duree2, X_Duree2, Y_Duree2
    PixelGetColor, duree3, X_Duree3, Y_Duree3
    PixelGetColor, duree4, X_Duree4, Y_Duree4

    ; Afficher les valeurs sur l'écran
    ToolTip, %reservMana%`n%life%/%lifeMax%`n%mana%/%manaMax%, 115, 720

        manaMaxResult := mem.read(mem.BaseAddress + staticAdress, "UInt", staticOffsetAll[1], staticOffsetAll[2], staticOffsetAll[3], staticOffsetAll[4], staticOffsetAll[5], staticOffsetAll[6], manaMaxOffset)
        manaMax := manaMaxResult + 0 ; Conversion explicite en nombre entier

        manaResult := mem.read(mem.BaseAddress + staticAdress, "UInt", staticOffsetAll[1], staticOffsetAll[2], staticOffsetAll[3], staticOffsetAll[4], staticOffsetAll[5], staticOffsetAll[6], manaOffset)
        mana := manaResult + 0 ; Conversion explicite en nombre entier

        lifeMaxResult := mem.read(mem.BaseAddress + staticAdress, "UInt", staticOffsetAll[1], staticOffsetAll[2], staticOffsetAll[3], staticOffsetAll[4], staticOffsetAll[5], staticOffsetAll[6], lifeMaxOffset)
        lifeMax := lifeMaxResult + 0 ; Conversion explicite en nombre entier

        lifeResult := mem.read(mem.BaseAddress + staticAdress, "UInt", staticOffsetAll[1], staticOffsetAll[2], staticOffsetAll[3], staticOffsetAll[4], staticOffsetAll[5], staticOffsetAll[6], lifeOffset)
        life := lifeResult + 0 ; Conversion explicite en nombre entier

        reservManaResult := mem.read(mem.BaseAddress + staticAdressReservation, "UInt", 0x90, 0x90, 0x30, 0x30, 0x1E8, 0x28, 0x2A0)
        reservMana := reservManaResult + 0 ; Conversion explicite en nombre entier

        manaMax -= reservMana

        ; Calculer les seuils en fonction des pourcentages
        seuil_vie := (pourcentage_seuil_vie / 100) * lifeMax
        seuil_mana := (pourcentage_seuil_mana / 100) * manaMax

        
        ; Vérifier si la vie est inférieure au seuil
        if (life < seuil_vie) {
            takeLife()
        }

        ; Vérifier si une des potions de vitesse est en cours et lance la potion si ce n'est pas le cas
        else if ((couleur4 == popo4) && duree4 != 0x99D7F9) {
            Send, 2
            Sleep, 100
        }

        ; Vérifier si une des potions de vitesse est en cours et lance la potion si ce n'est pas le cas
        else if ((couleur1 == popo1) && duree1 != 0x99D7F9) {
            Send, 3
            Sleep, 100
        }

        ; Vérifier si une des potions de vitesse est en cours et lance la potion si ce n'est pas le cas
        else if ((couleur2 == popo2) && duree2 != 0x99D7F9 && duree3 != 0x99D7F9) {
            Send, 4
            Sleep, 100
        } 

        ; Vérifier si une des potions de vitesse est en cours et lance la potion si ce n'est pas le cas
        else if ((couleur3 == popo3) && duree3!= 0x99D7F9 && duree2 != 0x99D7F9) {
            Send, 5
            Sleep, 100
        }

        Sleep, 100

    }
    return

    F2::reload

    ^F3::PotionPos()

    XButton2::
        Suspend
        Pause ,,1
        if A_IsPaused {
            ToolTip, PAUSED, 960, 1,
        } else {
            ToolTip, RUNNING, 960, 1,
            SetTimer RemoveToolTip,
        }
    return

    RemoveToolTip:
        ToolTip
        SetTimer, RemoveToolTip, Off
    return

    #Include, FindStaticAdresseAuto.ahk