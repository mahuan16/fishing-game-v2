extends Node2D

@onready var fishing_start_button: Button = $FishingStartButton
@onready var texture_rect: TextureRect = $sequenceofevents/TextureRect
@onready var test_dialogue_1: Node2D = $TestDialogue1

signal dialogue1_finished()
#@export var resource: PackedScene

func _ready(): 
	$FishingStartButton.visible = false 
	#if $FishingStartButton.is_action_pressed("left_click"):
		#print("something")
	dialogue1_finished.connect(_on_dialogue_finished)

#func _ready(): 
	
var resource = preload("res://dialogue/balloon.tscn")
#
#DialogueManager.show_dialogue_balloon(resource, "start")
## var dialogue1 = await DialogueManager.get_next_dialogue_line(resource, "start")

# below is dialogue manager stuff 
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"): 
		if Globals.dialogue_enabled == true: 
			var balloon: BaseGameDialogueBalloon = resource.instantiate()
			get_tree().root.add_child(balloon)
			
			balloon.dialogue_ended.connect(_on_dialogue_finished)
			
			balloon.start(load("res://dialogue/dialogue1.dialogue"), "start")
			#$FishingStartButton.visible = true 
			
			_on_dialogue_finished().emit()

@onready var game_manager: Node = %gameManager


#func _on_pressed() -> void:
	

func _on_dialogue_finished(): 
	game_manager.start_fishing()
	Globals.dialogue_enabled = false 
