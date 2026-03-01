extends Node2D

@onready var fish_database: Fish_Database = %fishDatabase
const FISH_SCENE = preload("uid://ptd54wdcx6by")
const FISH_ENTRY = preload("uid://clell2pn7sjji")

var currentFish : Node2D
var fishes : Array
var currentFishEntry : Node2D

var pageNum : int = 1
var fishEnd : int = 4

func _ready() -> void:
	#currentFish = FISH_SCENE.instantiate()
	fishes = fish_database.fish_array
	
	create_fish(fishEnd)
	#await get_tree().process_frame
	draw_fish(pageNum)
	

func create_fish(breakPoint : int) -> void:
	
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
		
		if index >= breakPoint:
			break
		
		
	
func draw_fish(pageNum : int) -> void:
	var xOri : int = 350
	var yOri : int = 100
	
	var x : int = xOri
	var y : int = yOri
	
	var vertSpacing : int = 250
	var horiSpacing : int = 425
	
	var column : int = 0 # 0-3
	var row : int = 0 # 0-2
	
	
	print("drawing fish")

		
		
		
	for i in range(fishEnd):
		var index : String = str(i)
		var fishChild = get_node(index)
		fishChild.scale = Vector2(0.1,0.1)
		fishChild.position = Vector2(x,y)
		var fishSprite = fishChild.fish_img
		print(Vector2(column, row))
		if fishSprite.texture.get_size().y >=2000:
			if column >= 1:
				y+=vertSpacing
				x = xOri
				row +=1
				column = 0
			else:
				x+= horiSpacing
				column += 1
		else:
			if row >= 1:
				x+=horiSpacing
				y = yOri
				column +=1
				row = 0
			else:
				y +=vertSpacing
				row +=1
		
			
		
