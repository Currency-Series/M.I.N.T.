Scriptname DES_DementiaCheckerScript extends activemagiceffect  

Quest Property DES_GibberSimpleServicesQuest auto
MiscObject Property DES_Gibber auto
MiscObject Property DES_GibberBack auto

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	(DES_GibberSimpleServicesQuest as DES_GibberCurrencySwapper).InMania = 0
	(DES_GibberSimpleServicesQuest as DES_GibberCurrencySwapper).InDementia = 1
	DES_Gibber.SetWorldModelPath("COIN/GibberBack.nif")
	DES_Gibber.SetGoldValue(DES_GibberBack.GetGoldValue())
	;debug.Messagebox("You are in Dementia.")
ENDEVENT