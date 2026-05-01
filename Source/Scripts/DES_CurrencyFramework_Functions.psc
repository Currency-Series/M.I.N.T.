Scriptname DES_CurrencyFramework_Functions extends Quest  

Import SEA_BarterFunctions 

Actor Property PlayerRef auto
MiscObject Property Gold001 auto

;--------------------------------------------------

Bool ShouldRevertCurrency
Form LastCurrency
Bool locationInList

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
GlobalVariable Property DES_ConvertCoins auto

Function ConvertCoins(formlist akSwapLocations, ObjectReference akSourceContainer, Form akBaseItem, int aiItemCount, GlobalVariable aiCoinWorth, Form akNewCoin)
	CheckLocation(akSwapLocations)
	IF locationInList
		IF !aksourceContainer && !(Game.GetCurrentCrosshairRef()).HasKeyword(DES_JobExchanger) && DES_ConvertCoins.GetValue() > 0
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

Function PayBountyCustomCurrency(actor akSpeaker, form coin)

	IF GetCurrency() != Gold001
		faction crimefaction = akSpeaker.GetCrimeFaction()
		int bounty = crimefaction.GetCrimeGold()
		PlayerRef.RemoveItem(coin, bounty)
		CrimeFaction.SetCrimeGold(0)
		CrimeFaction.SetCrimeGoldViolent(0)
		akSpeaker.GetCrimeFaction().PlayerPayCrimeGold()
	ELSE
		akSpeaker.GetCrimeFaction().PlayerPayCrimeGold()
	ENDIF

endFunction

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

Message Property DES_CurrencySwapperTutorialMessage auto

Event OnCustomBarterMenu(Actor a_kSeller)
	ShowTutorialMessage(DES_CurrencySwapperTutorialMessage)
endEvent