Scriptname DES_GoldConverter extends ReferenceAlias  

Quest Property DES_CurrencyFramework auto
Actor Property PlayerRef auto
MiscObject Property Gold001 auto

;--------------------------------------------------

Event OnInit()
	AddInventoryEventFilter(Gold001)
endEvent

;--------------------------------------------------

Event OnPlayerLoadGame()
	RemoveAllInventoryEventFilters()
	AddInventoryEventFilter(Gold001)
endEvent

;--------------------------------------------------

Actor Property exchanger auto
Formlist Property coinlocations auto
GlobalVariable Property coinworth auto
MiscObject Property newcoin auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF Exchanger
		IF !Exchanger.IsInDialogueWithPlayer()
			(DES_CurrencyFramework as DES_CurrencyFramework_Functions).ConvertCoins(coinlocations, akSourceContainer, akBaseItem, Gold001, aiItemCount, coinworth, newcoin)
		ENDIF
	ELSE
		(DES_CurrencyFramework as DES_CurrencyFramework_Functions).ConvertCoins(coinlocations, akSourceContainer, akBaseItem, Gold001, aiItemCount, coinworth, newcoin)
	ENDIF
EndEvent