extends Node2D


#if InputEventMouse():
#
var resource = preload("res://dialogue/balloon.tscn")
#
#DialogueManager.show_dialogue_balloon(resource, "start")
## var dialogue1 = await DialogueManager.get_next_dialogue_line(resource, "start")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"): 
		if Globals.dialogue_enabled == true: 
			var balloon: BaseGameDialogueBalloon = resource.instantiate()
			get_tree().root.add_child(balloon)
			balloon.start(load("res://dialogue/dialogue1.dialogue"), "start")
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/fisher_text.dialogue"), "start")
		#return 

#
#func _unhandled_input(event: InputEvent) -> void: 
	#if in_range: 
		#if event.is_action_pressed("show_dialogue"): 
			#var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate() 
			#get_tree().root.add_child(balloon) 
			#balloon.start(load("res://dialogue/conversations/guide.dialogue"), "start")
