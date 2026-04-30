;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__Barter Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(DES_CurrencyFramework as DES_CurrencyFramework_Functions).BarterCustomCurrency(akSpeaker, coin, pricemod)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property DES_CurrencyFramework auto
MiscObject Property currency auto
Perk Property pricemod auto
