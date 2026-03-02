extends Node2D

@onready var current_coins: Label = $currentCoins
const CATALOG = preload("res://scenes/catalog.tscn")
@onready var shop_button: Button = $shopButton

@onready var shop: Node2D = $shop

func _ready() -> void:
	shop.visible = false
	shop_button.visible = false
	shop_button.disabled = true

func updateCoins(newCoins : int) -> void:
	current_coins.text = str(newCoins)

func _on_catalog_button_pressed() -> void:
	var catalog = CATALOG.instantiate()
	get_parent().add_child(catalog)
	get_tree().paused = true

func _on_shop_button_pressed() -> void:
	shop.visible = true
	if shop.visible == true: 
		print("shop is visible")
	#shop.disable = false
	get_tree().paused = true

func _on_close_shop_pressed() -> void:
	shop.visible = false
	get_tree().paused = false
	#shop.disable = true
