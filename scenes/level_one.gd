extends Node2D

@onready var fishing_start_button: Button = $FishingStartButton
@onready var press_space_to_start = $sequenceofevents/TextureRect/PressSpaceToStart
@onready var test_dialogue_1: Node2D = $TestDialogue1

@onready var canvas_layer: CanvasLayer = $CanvasLayer


signal dialogue1_finished()
#@export var resource: PackedScene

@onready var boss_fish: Node2D = $bossFish


var dialogues_list = [ # because we need more dialogues than just that one at the beginning
	"res://dialogue/dialogue1.dialogue", 
	"res://dialogue/dialogue2.dialogue",
	"res://dialogue/dialogue3.dialogue"
]

var background1s: Array[Texture2D] = [
	preload("res://bg_anims/level-one-bg.png"),
	preload("res://bg_anims/level-one-bg2.png"),
	preload("res://bg_anims/level-one-bg3.png"),
	preload("res://bg_anims/level-one-bg4.png") 
]

func _ready(): 
	$FishingStartButton.visible = false 
	boss_fish.visible = false
	change_bg()
	$sequenceofevents/TextureRect/PressSpaceToStart.visible = true 
	#if $FishingStartButton.is_action_pressed("left_click"):
		#print("something")
	dialogue1_finished.connect(_on_dialogue_finished)
	print("Dialogue 1 connected")
	MidboatPurchased.midboat_purchased_changed.connect(_on_midboat_purchased)


@onready var animation_player: AnimationPlayer = $AnimationPlayer  # for fade
@onready var transition_audio: AudioStreamPlayer = $TransitionAudio

func _on_midboat_purchased() -> void:
	## Fade to black
	#canvas_layer.layer = 2
	#animation_player.play("fade_to_black")
	#await animation_player.animation_finished
	#
	## Play audio
	#transition_audio.play()
	#await transition_audio.finished
	
	# Change scene
	get_tree().change_scene_to_file("res://scenes/level_two.tscn")
	

func change_bg() -> void:
	var index := 0
	while true:
		$background/backgroundImg.texture = background1s[index]
		index = (index + 1) % background1s.size()
		await get_tree().create_timer(1.5).timeout # the speed at which the water changes 
	
var resource = preload("res://dialogue/balloon.tscn")
#
#DialogueManager.show_dialogue_balloon(resource, "start")
## var dialogue1 = await DialogueManager.get_next_dialogue_line(resource, "start")

# below is dialogue manager stuff 
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"): # upon pressing space, dialogue pops up 
		if Globals.dialogue_enabled == true: 
			Globals.dialogue_enabled = false # prevent re-triggering of the dialogues 
			press_space_to_start.visible = false
			await run_cycle() 
			#var balloon: BaseGameDialogueBalloon = resource.instantiate()
			#get_tree().root.add_child(balloon)
			#balloon.start(load("res://dialogue/dialogue1.dialogue"), "start")
			#DialogueManager.dialogue_ended.connect(_on_dialogue_finished)
			print("Connecting signal")
			
			
			
			#$FishingStartButton.visible = true 
@onready var reel_in: AudioStreamPlayer = $ReelIn
@onready var bob_in: AudioStreamPlayer = $BobIn

			#_on_dialogue_finished().emit()
var cycles = 3 
func run_cycle(): 
	for i in range(cycles): 
		"""
		CYCLE: 
		1. Dialogue ends
		2. Bubble animation instantiates; there's a random delay until the bubble animation plays.
		3. The start_fishing script plays upon the ending of the bubble animation.
		A dialogue plays after the player finishes catching a fish.
		The bubble animation waits until after the start_fishing script completely ends before starting again.
		The cycle repeats 3x, dialogue -> bubble -> fishing.
		"""
		# so first step is this: playing the dialogue 
		var balloon: BaseGameDialogueBalloon = resource.instantiate()
		get_tree().root.add_child(balloon)
		balloon.start(load(dialogues_list[i]), "start")
		await DialogueManager.dialogue_ended 
		bob_in.play()
		
		# second step is to play the bubble animation 
		var bubbles_appear = bubbles.instantiate()
		get_tree().root.add_child(bubbles_appear)
		bubbles_appear.global_position = Vector2(50, 130)
		
		var anim_player = bubbles_appear.get_node("AnimationPlayer")
		await anim_player.animation_finished
		
		# third step is to play the fishing scripts 
		bubbles_appear.queue_free() # get rid of bubble instances before the next round 
		reel_in.play()
		await game_manager.start_fishing() 
		
	print("3 cycles completed")
	while true:
		var bubbles_appear = bubbles.instantiate()
		get_tree().root.add_child(bubbles_appear)
		bubbles_appear.global_position = Vector2(50, 130)
		
		var anim_player = bubbles_appear.get_node("AnimationPlayer")
		await anim_player.animation_finished
		
		# third step is to play the fishing scripts 
		bubbles_appear.queue_free() # get rid of bubble instances before the next round 
		reel_in.play()
		await game_manager.start_fishing() 
		
	#balloon.start(load("res://dialogue/dialogue_boss1.dialogue"), "start")
	#var bossdialogue_1 = preload("res://dialogue/dialogue_boss1.dialogue")
	#DialogueManager.show_dialogue_balloon(bossdialogue_1, "start")
	#await DialogueManager.dialogue_ended 
	#for child in get_tree().root.get_children(): # get rid of all lingering dialogues if it's still there
		#if child is BaseGameDialogueBalloon:
			#child.queue_free()
	#boss_fight()
	#print(get_tree().root.get_children())
	

@onready var game_manager: Node = %gameManager


#func _on_pressed() -> void:
	
var bubbles := preload("res://scenes/bubble_anim.tscn")

func _on_dialogue_finished(dialogue): # I JUST NEEDED TO ADD A DAMNED DIALOGUE PARAMETER AND THEN THE DIALGOEU WEORANODN IT WORKS... 
	print("Signal connected")
	#print("Timer for 5 secs... started")
	#await get_tree().create_timer(3.0).timeout # wait 3 seconds
	#print("5-secs ended!")
	#var bubbles_appear = bubbles.instantiate()
	#get_tree().root.add_child(bubbles_appear)
	#bubbles_appear.global_position = Vector2(50, 130)
	#
	#var anim_player = bubbles_appear.get_node("AnimationPlayer")
	##anim_player.play("bubbling") 
	#await anim_player.animation_finished
	
	#game_manager.start_fishing()
	#Globals.dialogue_enabled = false 
	#$sequenceofevents/TextureRect/PressSpaceToStart.visible = false 
	print("visible: ", $sequenceofevents/TextureRect/PressSpaceToStart.visible) # to check if it's actually being set to invisible or not 


func boss_fight(): 
	#boss_fish.FISH_DATABASE = game_manager.fish_database
	#
	#boss_fish.assign_data()
	#boss_fish.visible = true
	#boss_fish.scale = Vector2(.15,.15)
	#boss_fish.position = Vector2(900,350)
	
	game_manager.start_boss_fish(1)
