Scriptname DES_CurrencyFramework_Functions extends Quest
{Shared functions for implementing custom currency mods.}

Import SEA_BarterFunctions 

;--------------------------------------------------
SHARED PROPERTIES
;--------------------------------------------------

Actor Property PlayerRef auto
MiscObject Property Gold001 auto

;--------------------------------------------------
SHARED VALUES
;--------------------------------------------------

Bool ShouldRevertCurrency
Form LastCurrency
Bool locationInList

;--------------------------------------------------
CURRENCY FUNCTIOINS
;--------------------------------------------------

Function SwapCurrency(formlist akSwapLocations, Perk akPriceMod, Form akCurrency)

	ShouldRevertCurrency = False
	If (!LastCurrency)
		ShouldRevertCurrency = True
	EndIf
	CheckLocation(akSwapLocations)
	IF locationInList
		IF (PlayerREF.HasPerk(akPriceMod))
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
		PlayerREF.AddPerk(akPriceMod)
		SetCurrency(akCurrency)
	ELSE
		IF GetCurrency() == akCurrency
			If (ShouldRevertCurrency)
				ResetCurrency()
			Else
				SetCurrency(LastCurrency)
			EndIf
			PlayerREF.RemovePerk(akPriceMod)
		ENDIF
	ENDIF

endFunction

;--------------------------------------------------

Function BarterCustomCurrency(Actor akVendor, Form akCurrency, Perk akPriceMod)

	If (PlayerRef.HasPerk(akPriceMod))
		PlayerRef.RemovePerk(akPriceMod)
	EndIf
	PlayerRef.AddPerk(akPriceMod)
	LastCurrency = GetCurrency()
	ShouldRevertCurrency = False
	If (!LastCurrency)
		ShouldRevertCurrency = True
	EndIf
	SetCurrency(akCurrency)
	akVendor.ShowBarterMenu()
	;Skyrim Souls compatibility
	While (Utility.IsInMenuMode())
		Utility.Wait(0.1)
	EndWhile
	;Skyrim Souls compatibility
	If (ShouldRevertCurrency)
		ResetCurrency()
	Else
		SetCurrency(LastCurrency)
	EndIf
	PlayerRef.RemovePerk(akPriceMod)

EndFunction

;--------------------------------------------------

Keyword Property DES_JobExchanger auto
Keyword Property DES_ConverterExclusion auto
GlobalVariable Property DES_ConvertCoins auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)
	
	CheckLocation(akSwapLocations)
	IF locationInList
		IF !aksourceContainer && !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_JobExchanger) && !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_ConverterExclusion) && DES_ConvertCoins.GetValue() > 0
			if akBaseItem == Gold001
				float count = aiItemCount*aiCoinWorth.GetValue()
				PlayerRef.removeItem(akBaseItem, aiItemCount as int, true)
				PlayerRef.addItem(akNewCoin, count as int)
			endif
		ENDIF
	ENDIF

endfunction

;--------------------------------------------------

Function ExchangeCoins(Form akOldCoin, int count, Form akNewCoin, GlobalVariable aiCoinWorth, bool divide = false)

	float worth = aiCoinWorth.GetValue()
	float newcount

	if divide
		newcount = count/worth
	else
		newcount = count*worth
	endif
	PlayerRef.RemoveItem(akOldCoin, count)
	PlayerRef.AddItem(akNewCoin, newcount as int)

endfunction

;--------------------------------------------------
UTILITY FUNCTIONS
;--------------------------------------------------

Function CheckLocation(formlist akSwapLocations)
	
	locationInList = false
	Location current = PlayerRef.GetCurrentLocation()
	locationInList = akSwapLocations.HasForm(current)
	while(!locationInList && current.GetParent())
		current = current.GetParent()
		locationInList = akSwapLocations.HasForm(current)
	endWhile

endFunction

;--------------------------------------------------
TUTORIAL
;--------------------------------------------------

Message Property DES_CurrencySwapperTutorialMessage auto

Event OnCustomBarterMenu(Actor a_kSeller)
	ShowTutorialMessage(DES_CurrencySwapperTutorialMessage)
endEvent
