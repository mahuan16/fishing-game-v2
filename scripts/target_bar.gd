extends Area2D

@export var min_length : int
@export var max_length : int

const width : int = 25

@onready var greenbar: Sprite2D = $greenbar

@onready var barshape: CollisionShape2D = $barshape

#func _ready() -> void:
	#var height : int = randi_range(min_length,max_length)
	#
	#greenbar.region_enabled = true
	#var barSize : Vector2 = greenbar.texture.get_size()
	#greenbar.region_rect = Rect2(0,0, 25, barSize.y)
	#var lengthScale : float = height/barSize.y
	#greenbar.scale = Vector2(1, lengthScale)
	#
	#barshape.shape.extents = Vector2(width/2, height/2)

func random_size() -> void:
	var height : int = randi_range(min_length,max_length)
	
	greenbar.region_enabled = true
	var barSize : Vector2 = greenbar.texture.get_size()
	greenbar.region_rect = Rect2(0,0, 25, barSize.y)
	var lengthScale : float = height/barSize.y
	greenbar.scale = Vector2(1, lengthScale)
	
	barshape.shape.extents = Vector2(width/2, height/2)

func get_length() -> int:
	return barshape.shape.extents.y
