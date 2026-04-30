Scriptname DES_CurrencyFramework_GoldConverter extends ReferenceAlias  

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

Formlist Property coinlocations auto
GlobalVariable Property coinworth auto
MiscObject Property newcoin auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	(DES_CurrencyFramework as DES_CurrencyFramework_Functions).ConvertCoins(coinlocations, akSourceContainer, akBaseItem, Gold001, aiItemCount, coinworth, newcoin)
EndEvent