;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__ExchangeRoom Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(DES_CurrencyFramework as DES_CurrencyFramework_Functions).ExchangeCoins(oldcoin, RoomCost.GetValue() as int, newcoin, coinworth)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property DES_CurrencyFramework auto
MiscObject Property oldcoin auto
GlobalVariable Property RoomCost auto
MiscObject Property newcoin auto
GlobalVariable Property coinworth auto
