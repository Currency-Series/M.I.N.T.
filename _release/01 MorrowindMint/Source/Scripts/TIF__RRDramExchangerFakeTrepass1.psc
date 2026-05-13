;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__RRDramExchangerFakeTrepass1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Debug.Notification("trespass")
Utility.Wait(7.5)
IF (GetOwningQuest() as DES_DramCurrencySwapper).Trespassing == 1
	;Debug.Notification("you are trespassing")
	akSpeaker.Say(DES_DramExchangerTresspassing)
ENDIF
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Topic Property DES_DramExchangerTresspassing auto
