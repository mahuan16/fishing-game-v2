extends Node2D

@onready var fish_database: Fish_Database = %fishDatabase
const FISH_SCENE = preload("uid://ptd54wdcx6by")

var currentFish : Node
func _ready() -> void:
	currentFish = FISH_SCENE.instantiate()
	

func create_fish() -> void:
	var fishes : Array = fish_database.fish_array
	for fish in fishes:
		currentFish.data = fish.data
		currentFish.set_data()
		currentFish.name = currentFish.display_name
		add_child(currentFish)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
