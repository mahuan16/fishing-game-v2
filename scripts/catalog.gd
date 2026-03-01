extends Node2D

@onready var fish_database: Fish_Database = %fishDatabase
const FISH_SCENE = preload("uid://ptd54wdcx6by")
const FISH_ENTRY = preload("uid://clell2pn7sjji")

var currentFish : Node2D
var fishes : Array
var currentFishEntry : Node2D

func _ready() -> void:
	#currentFish = FISH_SCENE.instantiate()
	fishes = fish_database.fish_array
	
	create_fish()
	draw_fish()
	

func create_fish() -> void:
	
	var index : int = 0
	for fish in fishes:
		
		currentFishEntry = FISH_ENTRY.instantiate()
		currentFishEntry.name = str(index)
		add_child(currentFishEntry)
		currentFishEntry.newdata = fish
		currentFishEntry.set_data()
		#print("made fish " + str(index))
		#print(currentFishEntry.fish_img)
		index += 1
		
	
func draw_fish() -> void:
	var x : int = 0
	var y : int = 0
	await get_tree().process_frame
	print("drawing fish")
	for i in range(fishes.size()):
		var index : String = str(i)
		var fishChild = get_node(index)
		fishChild.scale = Vector2(0.1,0.1)
		fishChild.position = Vector2(x,y)
		var fishSprite = fishChild.fish_img
		print(fishSprite.texture.get_size())
		if fishSprite.texture.get_size().y >=2000:
			x+= 204
			print("shift x")
		else:
			y +=180
			
		
