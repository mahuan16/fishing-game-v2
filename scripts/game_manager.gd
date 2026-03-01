extends Node

const FISH_SCENE = preload("res://scenes/fish_scene.tscn")

@onready var fish_database: Fish_Database = $fishDatabase
const FISH_GAUGE = preload("res://scenes/fish_gauge.tscn")
const PLAYER = preload("res://scenes/player.tscn")

# for the score counter 
@onready var panel = $CanvasLayer/Panel
@onready var you_caught_x = $CanvasLayer/Panel/YouCaughtX



var fish : Node
var player_instance
var gauge_instance

func _ready() -> void:
	fish = FISH_SCENE.instantiate()
	panel.visible = false # hide the panel to show the catches at the start

var scoreNum : int = 0
@onready var score: Label = $score

# damage fish function
func add_point() -> void:
	fish.hit_points -= 1
	if (fish.hit_points <= 0):
		#score.text = "You caught " + str(fish.display_name)
		end_fishing()

signal fishing_finished 

func start_fishing() -> void:
	var data : FishData = fish_database.fish_array.pick_random()
	fish.data = data
	fish.set_data()
	print(str(fish.hit_points))
	print(fish.display_name)
	create_fish_elements()
	await fishing_finished 
	

func create_fish_elements() -> void:
	player_instance = PLAYER.instantiate()
	gauge_instance = FISH_GAUGE.instantiate()
	
	# player settings + position
	player_instance.upperLimit = 540
	player_instance.lowerLimit = 100
	player_instance.global_position = Vector2(1152*.8,648/3)
	
	# gauge settings + position
	
	gauge_instance.min_length = 25
	gauge_instance.max_length = 50
	gauge_instance.global_position = Vector2(1152*.77,648*.5)
	
	
	add_child(gauge_instance)
	add_child(player_instance)
	
	print("displays created!")
	
func end_fishing() -> void:
	player_instance.queue_free()
	gauge_instance.queue_free()
	
# 	score.text = "You caught " + str(fish.display_name)
	
	you_caught_x.text = "Caught " + str(fish.display_name) + "!"
	panel.visible = true 
	
	await get_tree().create_timer(3.0).timeout # disappear after 3 secs
	panel.visible = false # disappear the panel after 3 secs
	
	fishing_finished.emit() # adds in a signal for the level_one script to know when fishing has finished 
