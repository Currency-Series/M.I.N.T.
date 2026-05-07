Scriptname DES_DramOfficePublicScript extends ObjectReference  

actor property DES_DramExchangerRef auto
actor property playerref auto
Quest Property DES_DramMorrowindServicesQuest auto

Event OnTriggerEnter(ObjectReference akActionRef)
	if akactionref == playerref
		(DES_DramMorrowindServicesQuest as DES_DramCurrencySwapper).Trespassing = 0
		DES_DramExchangerRef.EvaluatePackage()
	endif
EndEvent
