extends Node

@export var data : FishData
@onready var sprite_2d: Sprite2D = $Sprite2D

var hit_points : int
var display_name : String
var description : String
var price : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = data.sprite
	hit_points = data.health
	display_name = data.fishName
	description = data.fishDesc
	price = data.fishPrice
	
func set_data() -> void:
	#sprite_2d.texture = data.sprite
	hit_points = data.health
	display_name = data.fishName
	description = data.fishDesc
	price = data.fishPrice
	
