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
	#await get_tree().process_frame
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
		
	#draw_fish()
		print(currentFishEntry.fish_img.texture)
		index += 1
		
	
func draw_fish() -> void:
	var x : int = 250
	var y : int = 100
	
	var column : int = 0 # 0-3
	var row : int = 0 # 0-2
	
	print("drawing fish")
	for i in range(fishes.size()):
		var index : String = str(i)
		var fishChild = get_node(index)
		fishChild.scale = Vector2(0.1,0.1)
		fishChild.position = Vector2(x,y)
		var fishSprite = fishChild.fish_img
		print(Vector2(column, row))
		if fishSprite.texture.get_size().y >=2000:
			if column >= 3:
				y+=180
				x = 100
				row +=1
			else:
				x+= 250
			column += 1
		else:
			if row >= 2:
				x+=250
				y = 100
				column +=1
			else:
				y +=180
			row +=1
		
			
		
