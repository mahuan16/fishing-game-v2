extends Node2D # fish scene

@export var data : FishData
@onready var fish_sprite : Sprite2D = $fishSprite

var hit_points : int
var display_name : String
var description : String
var price : int
var new_fish : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_points = 0
	display_name = "empty"
	description = "emptydesc"
	price = 0
	#print(fish_sprite)
	#print(fish_sprite.texture)
	
	
func set_data() -> void:
	fish_sprite.texture = data.sprite
	hit_points = data.health
	display_name = data.fishName
	description = data.fishDesc
	price = data.fishPrice
	#print("set new fish data")

func get_sprite() -> Sprite2D:
	return fish_sprite
	
