;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname QF_DES_UlfricWindhelmService_03000002 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Calixto
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Calixto Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Oengul
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Oengul Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WindhelmHostler
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WindhelmHostler Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hillevi
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hillevi Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AvalAtheron
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AvalAtheron Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Torbjorn
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Torbjorn Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WindhelmHostlerBackup
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WindhelmHostlerBackup Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Madran
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Madran Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Hermir
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hermir Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY UlfricExchanger
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_UlfricExchanger Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CaptainLonelyGale
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CaptainLonelyGale Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jora
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jora Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Rolff
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Rolff Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Tova
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Tova Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Brunwulf
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Brunwulf Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Niranye
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Niranye Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Torsten
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Torsten Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nilsine
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nilsine Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
DES_UlfricExchangerDecreeScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
DES_UlfricExchangerDecreeScene.Stop()
Alias_AvalAtheron.trytoClear()

Alias_Hillevi.trytoClear()

Alias_Niranye.trytoClear()

Alias_Oengul.trytoClear()

Alias_Hermir.trytoClear()

Alias_Brunwulf.trytoClear()

Alias_CaptainLonelyGale.trytoClear()

Alias_Jora.trytoClear()

Alias_Nilsine.trytoClear()

Alias_Torbjorn.trytoClear()

Alias_Torsten.trytoClear()

Alias_Tova.trytoClear()
Alias_UlfricExchanger.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property DES_UlfricExchangerDecreeScene  Auto  

Quest Property DES_UlfricWindhelmServices  Auto  

MiscObject Property DES_Ulfric  Auto  
