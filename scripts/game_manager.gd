extends Node

const FISH_SCENE = preload("res://scenes/fish_scene.tscn")

@export var leastFish : int = 0
@export var mostFish : int = 4

@onready var fish_database: Fish_Database = $fishDatabase
const FISH_GAUGE = preload("res://scenes/fish_gauge.tscn")
const PLAYER = preload("res://scenes/player.tscn")

@onready var user_interface: Node2D = $user_interface

# for the score counter 
@onready var panel = $CanvasLayer/Panel
@onready var you_caught_x = $CanvasLayer/Panel/YouCaughtX

var fish : Node2D
var player_instance
var gauge_instance

@export var minLength = 25
@export var maxLength = 50

var coinCount : int = 0
var progress_bar : ProgressBar

var totalHealth : float = 1.0

func _ready() -> void:
	fish = FISH_SCENE.instantiate()
	add_child(fish)
	fish.visible = false  
	panel.visible = false # hide the panel to show the catches at the start


# damage fish function
func add_point() -> void:
	fish.hit_points -= 1
	if (fish.hit_points <= 0):
		coinCount += fish.price
		user_interface.updateCoins(coinCount)
		end_fishing()
		if progress_bar:
			destroy_health_bar()
	if progress_bar:
		update_health_bar()
	

signal fishing_finished 

func start_fishing() -> void:
	var randomFish : int = randi_range(leastFish,mostFish)
	var data : FishData = fish_database.fish_array[randomFish]
	fish.data = data
	fish.set_data()
	fish.visible = false 
	create_fish_elements()
	await fishing_finished 

func start_boss_fish(level : int) -> void:
	if level == 1:
		var data : FishData = fish_database.fish_array[15]
		fish.data = data
		fish.set_data()
		totalHealth = fish.hit_points
		
		fish.scale = Vector2(1.1,1.1)
		fish.position = Vector2(900,350)
		
		fish.visible = true 
		
		create_fish_elements()
		player_instance.SPEED = 400
		player_instance.global_position = Vector2(1152*.67,648/3)
		gauge_instance.global_position = Vector2(1152*.65,648*.5)
		
		create_health_bar()
		
	elif level == 2:
		var data : FishData = fish_database.fish_array[16]
		fish.data = data
		fish.set_data()
		totalHealth = fish.hit_points
		
		fish.scale = Vector2(2.2,2.2)
		fish.position = Vector2(950,350)
		
		fish.visible = true 
		
		create_fish_elements()
		player_instance.SPEED = 500
		player_instance.global_position = Vector2(1152*.67,648/3)
		gauge_instance.global_position = Vector2(1152*.65,648*.5)
		
		create_health_bar()
		progress_bar.global_position = Vector2(820, 50)
	elif level == 3:
		var data : FishData = fish_database.fish_array[17]
		fish.data = data
		fish.set_data()
		totalHealth = fish.hit_points
		
		fish.scale = Vector2(3.5,3.5)
		fish.position = Vector2(800,350)
		
		fish.visible = true 
		fish.z_index = -3
		
		create_fish_elements()
		player_instance.SPEED = 550
		player_instance.global_position = Vector2(1152*.6,648/3)
		gauge_instance.global_position = Vector2(1152*.58,648*.5)
		
		create_health_bar()
		progress_bar.global_position = Vector2(820, 50)
		
	await fishing_finished
	
func create_health_bar() -> void:
	progress_bar = ProgressBar.new()
	progress_bar.z_index = 7
	progress_bar.global_position = Vector2(800, 200)
	
	var bg := StyleBoxFlat.new()
	bg.bg_color = Color(0.15, 0.15, 0.15, 1.0)
	
	var fill := StyleBoxFlat.new()
	fill.bg_color = Color(0.7, 0.14, 0.14, 1.0) 
	
	progress_bar.add_theme_stylebox_override("background", bg)
	progress_bar.add_theme_stylebox_override("fill", fill)
	
	progress_bar.custom_minimum_size.x = 200
	progress_bar.value = 100
	
	add_child(progress_bar)
	
func destroy_health_bar() -> void:
	progress_bar.queue_free()
	
func update_health_bar() -> void:
	
	var percent : float = fish.hit_points/totalHealth

	progress_bar.value = percent*100

func create_fish_elements() -> void:
	player_instance = PLAYER.instantiate()
	gauge_instance = FISH_GAUGE.instantiate()
	
	# player settings + position
	player_instance.upperLimit = 540
	player_instance.lowerLimit = 100
	player_instance.global_position = Vector2(1152*.8,648/3)
	
	# gauge settings + position
	gauge_instance.min_length = minLength
	gauge_instance.max_length = maxLength
	gauge_instance.global_position = Vector2(1152*.77,648*.5)
	
	add_child(gauge_instance)
	add_child(player_instance)
	
func end_fishing() -> void:
	player_instance.queue_free()
	gauge_instance.queue_free()
	
# 	score.text = "You caught " + str(fish.display_name)
	
	fish.visible = true # show the fish now 
	fish.global_position = Vector2(970, 80)
	fish_database.fish_array[fish.fishID].found = true
	
	you_caught_x.text = "Caught " + str(fish.display_name) + "!"
	panel.visible = true 
	
	await get_tree().create_timer(1).timeout

	# slide up out of frame
	var tween := get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	var start_pos : Vector2 = fish.global_position
	var end_pos : Vector2 = start_pos + Vector2(0, -150)

	tween.tween_property(fish, "global_position", end_pos, 0.6)
	await tween.finished

	#await get_tree().create_timer(2.0).timeout # disappear after 3 secs
	panel.visible = false # disappear the panel after 3 secs
	fish.visible = false 
	
	fishing_finished.emit() # adds in a signal for the level_one script to know when fishing has finished 
