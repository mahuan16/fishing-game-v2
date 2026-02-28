extends Control

@onready var start: Button = $Start

var next_scene = "res://scenes/main_menu.tscn" # replace with actual level 1 scene 

func start_game() -> void: 
	get_tree().change_screen_to_file(next_scene)
