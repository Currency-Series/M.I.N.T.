;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname QF_DES_UlfricWindhelmService_03000002 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Calixto
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Calixto Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Madran
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Madran Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WindhelmHostlerBackup
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WindhelmHostlerBackup Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY UlfricExchanger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_UlfricExchanger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Niranye
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Niranye Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WindhelmHostler
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WindhelmHostler Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Rolff
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Rolff Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hermir
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hermir Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AvalAtheron
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AvalAtheron Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hillevi
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hillevi Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
Alias_UlfricExchanger.trytoEvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
DES_UlfricExchangerDecreeScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
Alias_Hillevi.trytoClear()
DES_DecreeXMarkerHillevi.Disable()
DES_DecreeXMarkerHillevi.Delete()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
Alias_Niranye.trytoClear()
DES_DecreeXMarkerNiranye.Disable()
DES_DecreeXMarkerNiranye.Delete()

Utility.Wait(2.0)

Alias_Hermir.trytoClear()
DES_DecreeXMarkerHermir.Disable()
DES_DecreeXMarkerHermir.Delete()

Utility.Wait(3.0)

Alias_AvalAtheron.trytoClear()
DES_DecreeXMarkerAval.Disable()
DES_DecreeXMarkerAval.Delete()

DES_UlfricExchangerDecreeScene.Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property DES_UlfricExchangerDecreeScene  Auto  

Quest Property DES_UlfricWindhelmServices  Auto  

MiscObject Property DES_Ulfric  Auto  

ObjectReference Property DES_DecreeXMarkerAval auto

ObjectReference Property DES_DecreeXMarkerHermir auto

ObjectReference Property DES_DecreeXMarkerHillevi auto

ObjectReference Property DES_DecreeXMarkerNiranye auto
