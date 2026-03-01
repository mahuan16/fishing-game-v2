extends Node2D # fish entry

const FISH_SCENE = preload("uid://ptd54wdcx6by")

var fish : Node2D
@export var newdata : FishData

@onready var fish_img: Sprite2D = $fishImg
@onready var fish_name: Label = $fishName
@onready var fish_description: Label = $fishDescription

var newFish : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = FISH_SCENE.instantiate()
	add_child(fish)
	#print("entry added to tree")
	
func set_data() -> void:
	fish.data = newdata
	fish.set_data()
	update_children()
	

func update_children() -> void:
	fish_img.texture = fish.fish_sprite.texture
	fish_name.text = fish.display_name
	fish_description.text = fish.description

	
	

	
	
