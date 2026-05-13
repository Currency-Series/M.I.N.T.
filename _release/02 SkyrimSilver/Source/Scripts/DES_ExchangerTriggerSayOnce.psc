Scriptname DES_ExchangerTriggerSayOnce extends ObjectReference  

Actor Property PlayerRef auto
Actor Property DES_UlfricExchangerRef auto
Quest Property DES_UlfricWindhelmServices auto
ObjectReference Property xMarkerHeading auto
Package Property DES_UlfricExchangerHoldDuringDecree auto

EVENT onTriggerEnter(objectReference triggerRef)
	if triggerRef == PlayerRef && DES_UlfricExchangerRef.GetCurrentPackage() == DES_UlfricExchangerHoldDuringDecree
		DES_UlfricWindhelmServices.SetStage(0)
		xMarkerHeading.Disable()
		xMarkerHeading.Delete()
		Disable()
		Delete()
	endif
ENDEVENT