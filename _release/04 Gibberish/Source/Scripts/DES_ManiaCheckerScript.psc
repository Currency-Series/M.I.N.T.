Scriptname DES_ManiaCheckerScript extends activemagiceffect  

Quest Property DES_GibberSimpleServicesQuest auto
MiscObject Property DES_Gibber auto
MiscObject Property DES_GibberFront auto

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	(DES_GibberSimpleServicesQuest as DES_GibberCurrencySwapper).InMania = 1
	(DES_GibberSimpleServicesQuest as DES_GibberCurrencySwapper).InDementia = 0
	DES_Gibber.SetWorldModelPath("COIN/GibberFront.nif")
	DES_Gibber.SetGoldValue(DES_GibberFront.GetGoldValue())
	;debug.Messagebox("You are in Mania.")
ENDEVENT
