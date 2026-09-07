	object_const_def
	const MAHOGANYREDGYARADOSSPEECHHOUSE_BLACK_BELT
	const MAHOGANYREDGYARADOSSPEECHHOUSE_MUNCHLAX
	const MAHOGANYREDGYARADOSSPEECHHOUSE_TEACHER
	

MahoganyRedGyaradosSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

; munchlax gift npc 
MahoganyRedGyaradosSpeechHouseBlackBeltScript:
;	jumptextfaceplayer MahoganyRedGyaradosSpeechHouseBlackBeltText
	faceplayer
	opentext
	checkevent EVENT_GOT_MUNCHLAX
	iftrue .GotMunchlax
	checkevent EVENT_GOT_SPECIAL_DISH
	iftrue .GiveMunchlax
	checkevent EVENT_START_MUNCHLAX_QUEST
	iftrue .GoToOlivineCafe
	writetext BeenHearingNoiseBehindHouseText
	yesorno
	iffalse .Refuse
	setevent EVENT_START_MUNCHLAX_QUEST
	writetext PlayerWillHelpText
	waitbutton
	;fall through
.GoToOlivineCafe:	
	writetext GoToOlivineCafeText
	waitbutton
	closetext
	end
.Refuse:
	writetext InvesitgateMyselfText
	waitbutton
	closetext
	end
.GotMunchlax:
	writetext HowMonDoingText
	waitbutton
	checkpoke SNORLAX
	iftrue .GotSnorlax
	closetext
	end
.GotSnorlax:
	writetext GotSnorlaxText
	waitbutton
	closetext
	end
.GiveMunchlax:
	checkevent EVENT_ENDED_MUNCHLAX_QUEST
	iftrue .MonWantToGo
	setevent EVENT_ENDED_MUNCHLAX_QUEST
	writetext MonWasMunchlaxText
	waitbutton
	takeitem SPECIAL_DISH
	verbosegiveitem NUGGET
	verbosegiveitem HARD_STONE
.MonWantToGo:
	writetext MonWantToGoText
	yesorno
	iffalse .KeepHere
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	writetext ReceivedMunchlaxText
	promptbutton
	givepoke MUNCHLAX, 20, LEFTOVERS
	setevent EVENT_GOT_MUNCHLAX
	setevent EVENT_SHOW_MUNCHLAX ;hidens munchlax
	disappear MAHOGANYREDGYARADOSSPEECHHOUSE_MUNCHLAX
	closetext
	end
.KeepHere:
	writetext KeepItHereText
	waitbutton
	closetext
	end
.PartyFull:
	writetext PartyIsFullText
	waitbutton
	closetext
	end
	
MunchlaxScript:
	opentext
	writetext MunchlaxText
	waitbutton
	closetext
	end
	
MunchlaxText:
	text "Munch?"
	done
	
	
BeenHearingNoiseBehindHouseText:
	text "Late at night I"
	line "have been hearing"
	cont "noises behind the"
	cont "house."
	cont "I think a #MON"
	cont "might be"
	cont "rummaging through"
	cont "our trashcans in"
	cont "search of food."
	para "If a #MON"
	line "is out there and"
	cont "hungry, I got to"
	cont "do something!"
	para "I thought of"
	line "making a"
	cont "delicious meal"
	cont "for it."
	cont "Will you help me?"
	done
	
PlayerWillHelpText:
	text "Great! I'm no"
	line "master cook so"
	cont "we'll need help"
	cont "from some"
	cont "professional."
	para "The best cook I"
	line "know of is the "
	cont "chef running the"
	cont "cafe in Olivine."
	done

GoToOlivineCafeText:
	text "Go to the cafe in"
	line "Olivine City and"
	cont "ask the chef for"
	cont "a special dish"
	cont "for a hungry"
	cont "#MON."
	done
	
InvesitgateMyselfText:
	text "Hmm. I'll have to"
	line "try and make it"
	cont "myself then."
	done

HowMonDoingText:
	text "Hey there!"
	line "I hope that little"
	cont "MUNCHLAX is doing"
	cont "well."
	done
	
GotSnorlaxText:
	text "It must be doing"
	line "very well."
	para "I'm glad to see"
	line "you became such"
	cont "good friends"
	cont "it could evolve"
	cont "into SNORLAX."
	done

MonWasMunchlaxText:
	text "Ha! It turned"
	line "out to be a little"
	cont "MUNCHLAX that was"
	cont "going through our"
	cont "trash."
	para "And this little"
	line "guy seem to really"
	cont "like my cooking,"
	cont "or the leftovers"
	cont "from it at least."
	cont "So I'm afraid that"
	cont "special dish you"
	cont "worked so hard for"
	cont "wasn't necessary"
	cont "after all."
	para "..."
	para "No wait."
	line "Ok it seems to"
	cont "really want the"
	cont "food."
	para "I'll give it to"
	line "him and then you"
	cont "can have this as"
	cont "thanks for all"
	cont "your trouble."
	done
	
MonWantToGoText:
	text "Say, you are a"
	line "#MON trainer"
	cont "right?"
	cont "I am no trainer"
	cont "and this little"
	cont "one seems to want"
	cont "to go see more"
	cont "than the mountains"
	cont "and my backyard."
	para "Will you take it"
	line "with you on your"
	cont "journeys?"
	done

KeepItHereText:
	text "That's also fine."
	line "It can live in"
	cont "the woods behind"
	cont "the house and I"
	cont "will keep giving"
	cont "it food as long"
	cont "as it needs."
	done
	
PartyIsFullText:
	text "Your party is too"
	line "full to take it"
	cont "with you right"
	cont "now."
	done
	
ReceivedMunchlaxText:
	text "<PLAYER> got"
	line "MUNCHLAX!"
	done
	

MahoganyRedGyaradosSpeechHouseTeacherScript:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .RocketsInRadioTower
;	writetext MahoganyRedGyaradosSpeechHouseTeacherText
	writetext MahoganyRedGyaradosSpeechHouseBlackBeltText
	waitbutton
	closetext
	end

.RocketsInRadioTower:
	writetext MahoganyRedGyaradosSpeechHouseTeacherText_RocketsInRadioTower
	waitbutton
	closetext
	end

MahoganyRedGyaradosSpeechHouseUnusedBookshelf1: ; unreferenced
	jumpstd PictureBookshelfScript

MahoganyRedGyaradosSpeechHouseUnusedBookshelf2: ; unreferenced
	jumpstd MagazineBookshelfScript

MahoganyRedGyaradosSpeechHouseBlackBeltText:
	text "I heard that a red"
	line "GYARADOS appeared"
	cont "at the LAKE."

	para "That's odd, since"
	line "even ordinary blue"

	para "GYARADOS are rare"
	line "in that lake…"
	done

MahoganyRedGyaradosSpeechHouseTeacherText:
	text "My favorite radio"
	line "program? I'd say"
	cont "#MON MUSIC."
	done

MahoganyRedGyaradosSpeechHouseTeacherText_RocketsInRadioTower:
	text "I've been hearing"
	line "laughter on the"

	para "radio…"
	line "It's creepy."
	done

MahoganyRedGyaradosSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, MAHOGANY_TOWN, 2
	warp_event  3,  7, MAHOGANY_TOWN, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyRedGyaradosSpeechHouseBlackBeltScript, -1
	object_event  3,  3, SPRITE_MUNCHLAX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MunchlaxScript, EVENT_SHOW_MUNCHLAX
	object_event  6,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MahoganyRedGyaradosSpeechHouseTeacherScript, -1
