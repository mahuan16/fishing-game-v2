extends Node

const FISH_SCENE = preload("res://scenes/fish_scene.tscn")

@onready var fish_database: Fish_Database = $fishDatabase
const FISH_GAUGE = preload("res://scenes/fish_gauge.tscn")
const PLAYER = preload("res://scenes/player.tscn")


var fish : Node

func _ready() -> void:
	fish = FISH_SCENE.instantiate()

var scoreNum : int = 0
@onready var score: Label = $score

func add_point() -> void:
	scoreNum += 1
	score.text = "Score: " + str(scoreNum)
	fish.hit_points -= 1
	if (fish.hit_points <= 0):
		score.text = "You caught " + str(fish.display_name)

func start_fishing() -> void:
	var data : FishData = fish_database.fish_array.pick_random()
	fish.data = data
	print(str(fish.hit_points))
	print(fish.display_name)
	create_fish_elements()
	

func create_fish_elements() -> void:
	var player_instance = PLAYER.instantiate()
	var gauge_instance = FISH_GAUGE.instantiate()
	
	# player settings + position
	player_instance.upperLimit = 540
	player_instance.lowerLimit = 100
	player_instance.global_position = Vector2(1152*.8,648/3)
	
	# gauge settings + position
	
	gauge_instance.min_length = 25
	gauge_instance.max_length = 50
	gauge_instance.global_position = Vector2(1152*.77,648*.5)
	
	add_child(player_instance)
	add_child(gauge_instance)
	
	print("displays created!")
	
