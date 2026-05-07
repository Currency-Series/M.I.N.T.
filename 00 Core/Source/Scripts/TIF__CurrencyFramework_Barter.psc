;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__CurrencyFramework_Barter Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
CurrencyFunctions.BarterCustomCurrency(akSpeaker, currency, pricemod)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
MiscObject Property currency auto
Perk Property pricemod auto
