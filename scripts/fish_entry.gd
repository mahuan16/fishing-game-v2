extends Node2D

const FISH_SCENE = preload("uid://ptd54wdcx6by")

var fish : Node
@export var data : FishData

@onready var fish_img: Sprite2D = $fishImg
@onready var fish_name: Label = $fishName
@onready var fish_description: Label = $fishDescription


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish = FISH_SCENE.instantiate()
	
func set_data() -> void:
	fish.data = data
	fish.set_data()

func update_children() -> void:
	fish_img.texture = fish.sprite
	fish_name.text = fish.display_name
	fish_description.text = fish.description

	
	

	
	
