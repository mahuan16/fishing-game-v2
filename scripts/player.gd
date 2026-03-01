extends CharacterBody2D

@export var upperLimit : int
@export var lowerLimit : int

var SPEED = 300.0
var direction : int = 1 # start going down

@onready var fish_shape: CollisionPolygon2D = $fishShape

func _physics_process(delta: float) -> void:
	
	if direction == 1:
		velocity.y = direction*SPEED
	else:
		velocity.y = direction*SPEED
		
	#var fishPoint : Vector2 = fish_shape.polygon[0]
	if position.y >= upperLimit:
		direction = -1
	elif position.y <= lowerLimit:
		direction = 1
	

	move_and_slide()
