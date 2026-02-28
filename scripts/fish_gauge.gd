extends Area2D

@onready var target_bar: Area2D = $targetBar
@onready var gauge_shape: CollisionShape2D = $gaugeShape
@onready var game_manager: Node = %gameManager
@onready var player: CharacterBody2D = %player

var inBar : bool = false # is player inside the bar area

@export var min_length : int
@export var max_length : int

func _ready() -> void:
	target_bar.min_length = min_length
	target_bar.max_length = max_length
	target_bar.random_size()
	var y_pos : int = randi_range(-gauge_shape.shape.extents.y+target_bar.get_length(), gauge_shape.shape.extents.y-target_bar.get_length())
	target_bar.position.y = y_pos
	
func random_loc() -> void:
	var y_pos : int = randi_range(-gauge_shape.shape.extents.y+target_bar.get_length(), gauge_shape.shape.extents.y-target_bar.get_length())
	target_bar.position.y = y_pos
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			target_bar.random_size()
			random_loc()
			if inBar:
				if game_manager:
					game_manager.add_point()
				else: # if we didnt get gamemanager properly
					get_parent().add_point()

func _on_target_bar_body_entered(body: Node2D) -> void:
	inBar = true

func _on_target_bar_body_exited(body: Node2D) -> void:
	inBar = false
