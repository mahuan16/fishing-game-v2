extends Node2D

@onready var current_coins: Label = $currentCoins
const CATALOG = preload("res://scenes/catalog.tscn")


func updateCoins(newCoins : int) -> void:
	current_coins.text = str(newCoins)

func _on_catalog_button_pressed() -> void:
	var catalog = CATALOG.instantiate()
	get_parent().add_child(catalog)
	get_tree().paused = true
