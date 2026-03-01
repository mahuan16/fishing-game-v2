extends Node2D

@onready var fish_database: Fish_Database = %fishDatabase
const FISH_SCENE = preload("res://scenes/fish_scene.tscn")
const FISH_ENTRY = preload("res://scenes/fish_entry.tscn")

@onready var nextPg: Button = $nextPg
@onready var backPg: Button = $backPg
@onready var fish_found_count: Label = $fishFoundCount


var fishes : Array
var currentFishEntry : Node2D

var pageNum : int = 1
var fishEnd : int = 4
var indexNum : int = 0

var fishFound : int = 0

func _ready() -> void:
	#currentFish = FISH_SCENE.instantiate()
	fishes = fish_database.fish_array
	backPg.visible = false
	
	create_fish()
	#await get_tree().process_frame
	draw_fish(pageNum)
	hide_fish()
	
	display_found()
	print("new cat")

func create_fish() -> void:
	#fishes = fish_database.fish_array
	var index : int = 0
	for fish in fishes:
		currentFishEntry = FISH_ENTRY.instantiate()
		currentFishEntry.name = str(index)
		add_child(currentFishEntry)
		currentFishEntry.newdata = fish
		currentFishEntry.set_data()
		
		index += 1
	
	print("made catalog")
		
	
func draw_fish(pageNum : int) -> void:
	var xOri : int = 350
	var yOri : int = 100
	
	var x : int = xOri
	var y : int = yOri
	
	var vertSpacing : int = 250
	var horiSpacing : int = 425
	
	var column : int = 0 # 0-3
	var row : int = 0 # 0-2
	
		
	for i in range(fishes.size()):
		var index : String = str(i)
		var fishChild = get_node(index)
		fishChild.scale = Vector2(0.1,0.1)
		fishChild.position = Vector2(x,y)
		#var fishSprite = fishChild.fish_img
		print(fishes[i].found)
		if not fishes[i].found:
			fishChild.modulate = Color(0,0,0,1)
			fishChild.fish_description.text = "Keep fishing to find me!"
		else:
			fishFound += 1
		
		if (row >= 1):
			x += horiSpacing
			column += 1
			row = 0
			y = yOri
			if column > 1:
				column = 0
				x = xOri
		else:
			y += vertSpacing
			row += 1
			
func display_found() -> void:
	fish_found_count.text = str(fishFound) +"/18"


func _on_next_pg_pressed() -> void:
	pageNum += 1
	check_buttons()

	
func check_buttons() -> void:
	
	if pageNum == 1:
		backPg.visible = false
	elif pageNum == 5:
		nextPg.visible = false
	else:
		nextPg.visible = true
		backPg.visible = true
	
	hide_fish()

func hide_fish() -> void:
	if pageNum == 1:
		for i in range(fishes.size()):
			var currentFish = get_node(str(i))
			if i > 3:
				currentFish.visible = false
			else:
				currentFish.visible = true
	elif pageNum == 2:
		for i in range(fishes.size()):
			var currentFish = get_node(str(i))
			if i > 7 or i < 4:
				currentFish.visible = false
			else:
				currentFish.visible = true
	elif pageNum == 3:
		for i in range(fishes.size()):
			var currentFish = get_node(str(i))
			if i > 11 or i < 8:
				currentFish.visible = false
			else:
				currentFish.visible = true
	elif pageNum == 4:
		for i in range(fishes.size()):
			var currentFish = get_node(str(i))
			if i > 15 or i < 12:
				currentFish.visible = false
			else:
				currentFish.visible = true
	elif pageNum == 5:
		for i in range(fishes.size()):
			var currentFish = get_node(str(i))
			if i < 16:
				currentFish.visible = false
			else:
				currentFish.visible = true
	

func _on_back_pg_pressed() -> void:
	pageNum -= 1
	check_buttons()
	

func _on_exit_out_pressed() -> void:
	get_tree().paused = false
	queue_free()
