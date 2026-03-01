extends Button

@onready var game_manager: Node = %gameManager

 

func _on_pressed() -> void:
	game_manager.start_fishing()
	Globals.dialogue_enabled = false 
