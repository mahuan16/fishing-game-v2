extends Node2D

const FISH_SCENE = preload("uid://ptd54wdcx6by")

var fish : Node
@export var data : FishData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = FISH_SCENE.instantiate()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_data():
	fish.data = data
	fish.set_data()

	
	

	
	
