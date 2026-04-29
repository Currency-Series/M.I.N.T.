Scriptname DES_CurrencyFramework_Functions extends Quest  

Import SEA_BarterFunctions 

Actor Property PlayerRef auto

;--------------------------------------------------

Bool ShouldRevertCurrency
Form LastCurrency

;--------------------------------------------------

Function SwapCurrency(formlist akSwapLocations, Perk akPriceMod, Form akCurrency)

	ShouldRevertCurrency = False
	If (!LastCurrency)
		ShouldRevertCurrency = True
	EndIf
	IF akSwapLocations.HasForm(PlayerRef.GetCurrentLocation()) || akSwapLocations.HasForm(PlayerRef.GetCurrentLocation().GetParent())
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

GlobalVariable Property DES_ConvertCoins auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, MiscObject Gold001, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)

	IF akSwapLocations.HasForm(PlayerRef.GetCurrentLocation()) || akSwapLocations.HasForm(PlayerRef.GetCurrentLocation().GetParent())
		IF !aksourceContainer && DES_ConvertCoins.GetValue() > 0
			if akBaseItem == Gold001
				float count = aiItemCount*aiCoinWorth.GetValue()
				PlayerRef.removeItem(akBaseItem, aiItemCount as int, true)
				PlayerRef.addItem(akNewCoin, count as int, true)
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
