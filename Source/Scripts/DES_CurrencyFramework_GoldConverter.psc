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

Formlist Property exchangers auto
Formlist Property coinlocations auto
GlobalVariable Property coinworth auto
MiscObject Property newcoin auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    bool isTalking = false
    IF Exchangers
        int i = 0
        int count = Exchangers.GetSize()
        WHILE i < count
            Actor exchangerActor = Exchangers.GetAt(i) as Actor
            IF exchangerActor && exchangerActor.IsInDialogueWithPlayer()
                isTalking = true
            ENDIF
            i += 1
        endwhile
    ENDIF
    IF !isTalking
        (DES_CurrencyFramework as DES_CurrencyFramework_Functions).ConvertCoins(coinlocations, akSourceContainer, akBaseItem, Gold001, aiItemCount, coinworth, newcoin)
    ENDIF
EndEvent
