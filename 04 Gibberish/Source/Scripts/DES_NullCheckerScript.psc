Scriptname DES_NullCheckerScript extends activemagiceffect  

Quest Property DES_GibberSimpleServicesQuest  auto

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	(DES_GibberSimpleServicesQuest  as DES_GibberCurrencySwapper).InMania = 0
	(DES_GibberSimpleServicesQuest as DES_GibberCurrencySwapper).InDementia = 0
ENDEVENT

