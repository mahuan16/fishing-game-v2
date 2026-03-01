extends Node2D

@export var FISH_DATABASE : Fish_Database

const FISH_SCENE = preload("res://scenes/fish_scene.tscn")
@export var currentLevel : int = 1
@onready var boss_sprite: Sprite2D = $bossSprite

var boss : Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boss = FISH_SCENE.instantiate()

func assign_data() -> void:
	if currentLevel == 1:
		boss.data = FISH_DATABASE.fish_array[15]
		
	
	
	boss_sprite.texture = boss.data.sprite
	
	
