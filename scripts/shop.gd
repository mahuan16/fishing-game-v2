extends Node2D

# middle level boat
@onready var mid_boat: Area2D = $midBoat
@onready var purchased: Sprite2D = $midBoat/purchased
@onready var soldout: Sprite2D = $midBoat/soldout
var midPrice : int = 150

@onready var game_manager = get_parent().get_parent()
@onready var user_interface = get_parent()

# deep level boat
@onready var deep_boat: Area2D = $deepBoat
@onready var purchased_deep: Sprite2D = $deepBoat/purchased
@onready var soldout_deep: Sprite2D = $deepBoat/soldout
@onready var refusal: Label = $deepBoat/refusal
var deepPrice : int = 1000

var mid_boat_selected : bool = false
var deep_boat_selected : bool = false

var currentCoinCount : int = 0

var click_cooldown := 0.4
var last_click_time := -100.0


func _ready() -> void:
	purchased.visible = false
	soldout.visible = false
	purchased_deep.visible = false
	soldout_deep.visible = false

func _input(event: InputEvent) -> void:
	var now := Time.get_ticks_msec() / 1000.0

	if now - last_click_time < click_cooldown:
		return  # ignore spam
	last_click_time = now
	
	if event is InputEventMouseButton:
		if mid_boat_selected:
			if checkMoney("mid"):
				purchased.visible = true
				soldout.visible = true
				game_manager.coinCount -= midPrice
				user_interface.updateCoins(game_manager.coinCount)
			else:
				refuse_purchase(1)
		elif deep_boat_selected:
			if purchased.visible:
				if checkMoney("deep"):
					purchased_deep.visible = true
					soldout_deep.visible = true
					game_manager.coinCount -= deepPrice
					user_interface.updateCoins(game_manager.coinCount)
				else:
					refuse_purchase(1)
			else:
				refuse_purchase(0)
				
			
func refuse_purchase(mode : int) -> void:
	refusal.modulate.a = 1
	if mode == 0:
		refusal.text = "Must purchase other boat first"
	else:
		refusal.text = "Not enough coins!"
	await get_tree().create_timer(1.0).timeout
	await fadeText(1, refusal)

func fadeText(duration : int, text : Label) -> void:
	var tween = create_tween()
	tween.tween_property(text, "modulate:a", 0.0, duration)
	
func checkMoney(boat : String) -> bool:
	var price : int = 0
	if boat == "mid":
		price = midPrice
	else:
		price = deepPrice
	if game_manager.coinCount < price:
		return false
	else:
		return true

func _on_mid_boat_mouse_entered() -> void:
	mid_boat_selected = true

func _on_mid_boat_mouse_exited() -> void:
	mid_boat_selected = false

func _on_deep_boat_mouse_entered() -> void:
	deep_boat_selected = true

func _on_deep_boat_mouse_exited() -> void:
	deep_boat_selected = false
