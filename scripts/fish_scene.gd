extends Node2D

@export var data : FishData
@onready var fish_sprite: Sprite2D = $fishSprite


var hit_points : int
var display_name : String
var description : String
var price : int
var new_fish : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#sprite_2d.texture = data.sprite
	hit_points = data.health
	display_name = data.fishName
	description = data.fishDesc
	price = data.fishPrice
	
func set_data() -> void:
	fish_sprite.texture = data.sprite
	hit_points = data.health
	display_name = data.fishName
	description = data.fishDesc
	price = data.fishPrice

func get_sprite() -> Sprite2D:
	return fish_sprite
	
