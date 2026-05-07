Scriptname DES_GibberCurrencySwapperAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
	(GetOwningQuest() as DES_GibberCurrencySwapper).OnPlayerLoadGame_Alias()
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	(GetOwningQuest() as DES_GibberCurrencySwapper).OnItemAdded_Alias(akBaseItem)
endEvent