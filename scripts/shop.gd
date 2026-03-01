extends Node2D

# middle level boat
@onready var mid_boat: Area2D = $midBoat
@onready var purchased: Sprite2D = $midBoat/purchased
@onready var soldout: Sprite2D = $midBoat/soldout

# deep level boat
@onready var deep_boat: Area2D = $deepBoat
@onready var purchased_deep: Sprite2D = $deepBoat/purchased
@onready var soldout_deep: Sprite2D = $deepBoat/soldout
@onready var refusal: Label = $deepBoat/refusal



var mid_boat_selected : bool = false
var deep_boat_selected : bool = false

func _ready() -> void:
	purchased.visible = false
	soldout.visible = false
	purchased_deep.visible = false
	soldout_deep.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if mid_boat_selected:
			print("midboat clicked")
			purchased.visible = true
			soldout.visible = true
		elif deep_boat_selected:
			if purchased.visible:
				purchased_deep.visible = true
				soldout_deep.visible = true
			else:
				refuse_purchase()
				
			
func refuse_purchase() -> void:
	refusal.modulate.a = 1
	refusal.text = "Must purchase other boat first"
	await get_tree().create_timer(1.0).timeout
	await fadeText(1, refusal)

func fadeText(duration : int, text : Label) -> void:
	var tween = create_tween()
	tween.tween_property(text, "modulate:a", 0.0, duration)
	

func _on_mid_boat_mouse_entered() -> void:
	mid_boat_selected = true

func _on_mid_boat_mouse_exited() -> void:
	mid_boat_selected = false

func _on_deep_boat_mouse_entered() -> void:
	deep_boat_selected = true

func _on_deep_boat_mouse_exited() -> void:
	deep_boat_selected = false
