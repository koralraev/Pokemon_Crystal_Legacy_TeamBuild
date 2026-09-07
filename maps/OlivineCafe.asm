	object_const_def
	const OLIVINECAFE_SAILOR1
	const OLIVINECAFE_FISHING_GURU
;	const OLIVINECAFE_SAILOR2
	const OLIVINECAFE_SILPHCO_WORKER

OlivineCafe_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineCafeStrengthSailorScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM04_STRENGTH
	iftrue .GotStrength
	writetext OlivineCafeStrengthSailorText
	promptbutton
	verbosegiveitem HM_STRENGTH
	setevent EVENT_GOT_HM04_STRENGTH
.GotStrength:
	writetext OlivineCafeStrengthSailorText_GotStrength
	waitbutton
	closetext
	end

OlivineCafeFishingGuruScript: ; the chef
;	jumptextfaceplayer OlivineCafeFishingGuruText
	faceplayer
	opentext
	checkevent EVENT_START_MUNCHLAX_QUEST ; check if we started the quest
	iffalse .ChefNormalRoutine
	checkevent EVENT_GOT_SPECIAL_DISH
	iftrue .ChefNormalRoutine
	
	checkevent EVENT_TALKED_TO_CHEF ; did we already talk to the chef?
	iffalse .ChefRequestSpecialDish
	
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	checkitem HARD_STONE
	iffalse .CheckHardStone
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	;fall through
.CheckHardStone:
	callasm CheckCompletedIngredientsASM ;checks all three flags for items
	; returns unique number for possible completion combination
	ifequal 7, .GotAll
	ifequal 6, .GotBerryAndStone
	ifequal 5, .GotRootAndStone
	ifequal 4, .GotStone
	ifequal 3, .GotRootAndBerry
	ifequal 2, .GotBerry
	ifequal 1, .GotRoot
;	ifequal 0, .ChefGetItemsForDish
	writetext ChefGetItemsForDishText ;items can be found XYZ
	waitbutton
	closetext
	end
	
.GotAll:
	writetext ChefGotAllText
	takeitem HARD_STONE
	takeitem NUTRI_ROOT
	takeitem BERRYMIX
	waitbutton
	closetext
	applymovement OLIVINECAFE_FISHING_GURU, OlivineCafeChefSpin_MovementData
	playsound SFX_DEX_FANFARE_20_49
	pause 30
	opentext
	writetext ChefGiveSpecialDishText
	waitbutton
	verbosegiveitem SPECIAL_DISH
	setevent EVENT_GOT_SPECIAL_DISH
	clearevent EVENT_SHOW_MUNCHLAX
	promptbutton
	closetext
	end
	
.GotBerryAndStone:
	writetext ChefGotBerryAndStoneText
	waitbutton
	closetext
	end

.GotRootAndStone:
	writetext ChefGotRootAndStoneText
	waitbutton
	closetext
	end

.GotStone:
	writetext ChefGotStoneText
	waitbutton
	closetext
	end
	
.GotRootAndBerry:
	writetext ChefGotRootAndBerryText
	waitbutton
	closetext
	end

.GotBerry:
	writetext ChefGotBerryText
	waitbutton
	closetext
	end
	
.GotRoot:
	writetext ChefGotRootText
	waitbutton
	closetext
	end
	
.ChefRequestSpecialDish:
	writetext ChefRequestSpecialDishText ;dish for pokemon?
	setevent EVENT_TALKED_TO_CHEF
	waitbutton
	;fall through to hint item locations
.ChefGetItemsForDish:
	writetext ChefGetItemsForDishText ;items can be found XYZ
	waitbutton
	closetext
	end	
	
.ChefNormalRoutine:
	writetext OlivineCafeFishingGuruText
	waitbutton
	closetext
	end

;OlivineCafeSailorScript:
;	jumptextfaceplayer OlivineCafeSailorText
	
OlivineCafeSilphCoWorkerScopeLens:
	faceplayer
	opentext
	checkevent EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	iffalse .MagnetTrainWorking
	checkevent EVENT_HIDDEN_SCOPE_LENS
	iftrue .GotScopeLens
	writetext OlivineCafeGiveScopeLens
	promptbutton
	verbosegiveitem SCOPE_LENS
	setevent EVENT_HIDDEN_SCOPE_LENS
	writetext OlivineCafeGotScopeLens
	waitbutton
	closetext
	end
.GotScopeLens:
	writetext OlivineCafeGotScopeLens
	waitbutton
	closetext
	end
.MagnetTrainWorking:
	writetext OlivineCafeMagnetTrainWorkingText
	waitbutton
	checkevent EVENT_HIDDEN_SCOPE_LENS
	iffalse .GiveScopeLens
	closetext
	end
.GiveScopeLens:
	writetext OlivineCafeGiveScopeLens2Text
	waitbutton
	verbosegiveitem SCOPE_LENS
	setevent EVENT_HIDDEN_SCOPE_LENS
	waitbutton
	closetext
	end
	
OlivineCafeChefSpin_MovementData:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	step_end

OlivineCafeStrengthSailorText:
	text "Hah! Your #MON"
	line "sure look like"
	cont "lightweights!"

	para "They don't have"
	line "the power to move"
	cont "boulders aside."

	para "Here, use this"
	line "and teach them"
	cont "STRENGTH!"
	done

OlivineCafeStrengthSailorText_GotStrength:
	text "On the sea, the"
	line "only thing you can"

	para "count on is your"
	line "own good self!"

	para "I'm so proud of my"
	line "buff bod!"
	done

OlivineCafeFishingGuruText:
	text "OLIVINE CAFE's"
	line "menu is chock full"

	para "of hearty fare for"
	line "beefy SAILORS!"
	done

;OlivineCafeSailorText:
;	text "Whenever I roll"
;	line "into this town, I"

;	para "always visit the"
;	line "OLIVINE CAFE."

;	para "Everything on the"
;	line "menu makes me feel"

;	para "stronger. I can't"
;	line "stop eating!"
;	done
	
OlivineCafeGiveScopeLens:
	text "What am I to do?"
	
	para "I work for Silph"
	line "in Kanto, but with"
	cont "the Magnet Train"
	cont "not running I can't"
	cont "get back!"
	
	para "I've been here in"
	line "Johto to research"
	cont "and develop a"
	cont "brand new battle"
	cont "item."
	
	para "I call it the"
	line "SCOPE LENS!"
	
	para "It inceases the"
	line "chance of landing"
	cont "critical hits!"
	
	para "Hey, you are a"
	line "#MON trainer!"

	para "Why don't you take"
	line "this prototype?"
	done
	
OlivineCafeGotScopeLens:
	text "The SCOPE LENS"
	line "increase critical"
	cont "hit chance."
	
	para "Don't worry."
	line "I can make a new"
	cont "back at Silph Co."
	
	para "I'm sure the"
	line "President won't"
	cont "mind it being"
	cont "promoted a bit"
	cont "before it hits"
	cont "the shelves."
	done

OlivineCafeMagnetTrainWorkingText:
	text "The Magnet Train"
	line "is working again!"
	para "I have gotten to"
	line "like it here in"
	cont "Olivine so I have"
	cont "decided to stay a"
	cont "bit longer."
	para "How is the SCOPE"
	line "LENS working for"
	cont "you? Are you"
	cont "getting some"
	cont "critical hits?"
	done
OlivineCafeGiveScopeLens2Text:
	text "Oh, you are not?"
	line "Well I can give"
	cont "you this to help"
	cont "you then."
	done
	

ChefGotAllText:
	text "You got all the"
	line "ingredients!"
	cont "Great!"
	para "If you give them"
	line "here, I'll prepare"
	cont "the dish right"
	cont "away."
	done

ChefGiveSpecialDishText:
	text "Here you go."
	line "It's a very"
	cont "SPECIAL DISH."
	done
	
ChefGotBerryAndStoneText:
 	text "You got the stone"
 	line "and berries."
 	cont "Great!"
 	para "Now you just need"
 	line "the root."
 	cont "NUTRIOUS ROOTs"
 	cont "can be found"
 	cont "in Ilex Forest."
 	done
 
ChefGotRootAndStoneText:
	text "You got the root"
	line "and stone."
	cont "Great!"
	para "Now you just need"
	line "the BERRYMIX."
	cont "My best guess to"
	cont "get it is at the"
	cont "Goldenrod Flower"
	cont "Shop. They might"
	cont "know about"
	cont "berries."
	done
	
ChefGotStoneText:
	text "You got the stone."
	line "Great!"
	para "Now you just need"
	line "the root and"
	cont "berries."
	cont "NUTRIOUS ROOTs"
 	cont "can be found"
 	cont "in Ilex Forest."
 	para "My best guess to"
 	line "get the BERRYMIX"
 	cont "is at the Flower"
 	cont "Shop in Goldenrod."
 	cont "They might know"
 	cont "about berries."
 	done
 	
ChefGotRootAndBerryText:
	text "You got the root"
	line "and berries."
	cont "Great!"
	para "Now you just need"
	line "a HARD STONE."
	cont "I don't know"
	cont "exactly where to"
	cont "find one, but"
	cont "I guess try"
	cont "look around in"
	cont "caves."
	done

ChefGotBerryText:
	text "You got the"
	line "BERRYMIX."
	cont "Great!"
	para "Now you just need"
	line "the root and a"
	cont "HARD STONE."
	cont "NUTRIOUS ROOTs"
 	cont "can be found"
 	cont "in Ilex Forest."
 	para "I don't know"
	line "where to find a"
	cont "HARD STONE, but"
	cont "I guess try"
	cont "look around in"
	cont "caves."
	done
	
ChefGotRootText:
	text "You got the"
	line "NUTRI ROOT."
	cont "Great!"
	para "Now you just need"
	line "the berries and a"
	cont "HARD STONE."
	para "My best guess to"
 	line "get the BERRYMIX"
 	cont "is at the Flower"
 	cont "Shop in Goldenrod."
 	cont "They might know"
 	cont "about berries."
	para "I don't know"
	line "where to find a"
	cont "HARD STONE, but"
	cont "I guess try"
	cont "look around in"
	cont "caves."
	done
	
ChefRequestSpecialDishText:
	text "Food for #MON?"
	line "Not normally, but"
	cont "I have had this"
	cont "idea for a really"
	cont "delicious dish"
	cont "specially for"
	cont "#MON I want"
	cont "to try."
	para "I need some rare"
	line "ingredients to"
	cont "make it though."
	para "If you can bring"
	line "me a NUTRI ROOT,"
	cont "a BERRYMIX, and a"
	cont "HARD STONE, I can"
	cont "make you the dish."
	done
	
ChefGetItemsForDishText:
	text "There are many"
	line "rare ingredients"
	cont "like mushrooms and"
	cont "roots in Ilex"
	cont "Forest."
	cont "Try looking around"
	cont "there for a"
	cont "NUTRI ROOT."
	para "For the BERRYMIX"
	line "your best bet is"
	cont "the Flower Shop in"
	cont "Goldenrod."
	para "They have a Berry"
	line "Shop inside so"
	cont "some of them must"
	cont "know about mixing"
	cont "berries."
	para "The HARD STONE"
	line "might sound wierd"
	cont "for a dish, but"
	cont "you can extract"
	cont "rock salt from it"
	cont "which gives a"
	cont "unique flavour."
	para "I don't know where"
	line "to find one though"
	cont "but I guess try"
	cont "look around in"
	cont "caves."
	done
	
	
CheckCompletedIngredientsASM:
	xor a
	ld [wScriptVar], a
	
	ld de, EVENT_GOT_NUTRI_ROOT ; task 1
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .GotNoRoot
	ld a, [wScriptVar]
	add 1
	ld [wScriptVar], a
.GotNoRoot:	
	ld de, EVENT_GOT_BERRYMIX ;task 2
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .GotNoBerryMix
	ld a, [wScriptVar]
	add 2
	ld [wScriptVar], a
.GotNoBerryMix:
	ld de, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; task 3
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a               
	jr z, .GotNoHardStone
	ld a, [wScriptVar]
	add 4               
	ld [wScriptVar], a
.GotNoHardStone:
	ret
	

OlivineCafe_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 7
	warp_event  3,  7, OLIVINE_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeStrengthSailorScript, -1
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeFishingGuruScript, -1
;	object_event  6,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeSailorScript, -1
	object_event  7,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeSilphCoWorkerScopeLens, -1
