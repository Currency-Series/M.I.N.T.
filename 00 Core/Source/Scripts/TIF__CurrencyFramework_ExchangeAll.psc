;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__CurrencyFramework_ExchangeAll Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
CurrencyFunctions.ExchangeCoins(oldcoin, PlayerRef.GetItemCount(oldcoin), newcoin, coinworth, divide)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
MiscObject Property oldcoin auto
Actor Property PlayerRef auto
MiscObject Property newcoin auto
GlobalVariable Property coinworth auto
Bool Property divide auto
