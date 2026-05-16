Scriptname DES_CurrencyFramework_GoldConverter extends ReferenceAlias
{Converts all script-added Gold to custom currency while in swapped locations. Useful to ensuring that quest rewards are given in the correct currency. Place on Alias.}

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
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
	IF akBaseItem == Gold001
		CurrencyFunctions.ConvertCoins(coinlocations, akSourceContainer, akBaseItem, aiItemCount, coinworth, newcoin)
	ENDIF
EndEvent
