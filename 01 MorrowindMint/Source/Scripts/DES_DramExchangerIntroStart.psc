Scriptname DES_DramExchangerIntroStart extends ObjectReference  

Actor Property PlayerRef auto
Actor Property DES_DramExchangerRef auto
Topic Property DES_DramExchangerIntro01 auto

EVENT OnTriggerEnter(ObjectReference akActionRef)
	IF akActionRef == PlayerRef
		DES_DramExchangerRef.Say(DES_DramExchangerIntro01)
		Disable()
		Delete()
	ENDIF
ENDEVENT