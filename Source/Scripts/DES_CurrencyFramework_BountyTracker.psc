Scriptname DES_CurrencyFramework_BountyTracker extends Quest  

Event OnStoryCrimeGold(ObjectReference akVictim, ObjectReference akCriminal, Form akFaction, int aiGoldAmount, int aiCrime)
	debug.notification("Crime!!!")
	CurrencyFunctions.SetBountyCustomCurrency(akVictim, akSwapLocations, aiGoldAmount, CustomBounty)
	debug.notification(custombounty.getvalue())
endEvent

DES_CurrencyFramework_Functions Property CurrencyFunctions auto
Formlist Property akSwapLocations auto
GlobalVariable Property CustomBounty auto