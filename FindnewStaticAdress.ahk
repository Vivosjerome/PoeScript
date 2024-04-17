#SingleInstance Force
#Include, classMemory.ahk


global staticAdress := 0x318AB88
global staticAdressReservation := 0x318E4E8

global manaSave :=
global reservationSave :=

global offsets1 := [0x28, 0x58, 0x50, 0x30, 0x20, 0x190, 0x1F4]
global offsets2 := [0x90, 0x90, 0x30, 0x30, 0x1E0, 0x48, 0x2A8]

if !(manaSave){
    InputBox, manaSave, Mana, Entre le mana max que tu as :
    }

if !(reservationSave){
    InputBox, reservationSave, reserv, Entre la reserv que tu as :
    }

findNewAdress(staticAdress, offsets1, manaSave)

findNewAdress(staticAdressReservation, offsets2, reservationSave)

findNewAdress(adress, offsets, save){

    initialAdresse := adress
    Loop {
        mem := new _ClassMemory("ahk_exe PathOfExileSteam.exe", "", hProcessCopy) 

        if !isObject(mem) {
            MsgBox Erreur lors de l'ouverture du handle
            ExitApp ; Ajoutez une sortie en cas d'erreur
        }

        if !hProcessCopy {
            MsgBox Erreur lors de l'ouverture du handle. Code d'erreur = %hProcessCopy%
            ExitApp ; Ajoutez une sortie en cas d'erreur
        }

        ; Boucle jusqu'à ce que la condition soit bonne
        Loop, 100000{
            manaMaxResult := mem.read(mem.BaseAddress + adress, "UInt", offsets[1], offsets[2], offsets[3], offsets[4], offsets[5], offsets[6], offsets[7] )
            manaMax := manaMaxResult + 0 ; Conversion explicite en nombre entier
            ; Libérez les ressources après chaque lecture
            mem.Close()
            
            if (manaMax == save) {
                MsgBox, %adress%
                Clipboard := adress
                Return
            }

            adress -= 1
            adress := Format("0x{:X}", adress)
            
        }

        ;Réinitialiser l'adresse
        adress := initialAdresse

        ; Boucle jusqu'à ce que la condition soit bonne
        Loop, 100000{
            manaMaxResult := mem.read(mem.BaseAddress + adress, "UInt", offsets[1], offsets[2], offsets[3], offsets[4], offsets[5], offsets[6], offsets[7] )
            manaMax := manaMaxResult + 0 ; Conversion explicite en nombre entier
            ; Libérez les ressources après chaque lecture
            mem.Close()
            
            if (manaMax == save) {
                MsgBox, %adress%
                Clipboard := adress
                Return
            }

            adress += 1
            adress := Format("0x{:X}", adress)
            
        }

    }

}
