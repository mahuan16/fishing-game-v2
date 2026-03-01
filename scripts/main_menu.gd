extends Control

@onready var start: Button = $Start
@onready var help: Button = $Help
@onready var instruc = $Instructions
@onready var exit_instruc: Button = $ExitHelp

var next_scene = "res://scenes/level_one.tscn" # replace with actual level 1 scene 

func _ready():
	instruc.hide()
	exit_instruc.hide()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(next_scene)

func _on_help_pressed() -> void:
	instruc.show()
	exit_instruc.show()

func _on_exit_help_pressed() -> void:
	instruc.hide()
	exit_instruc.hide()
