extends Node

signal midboat_purchased_changed

@export var midboat_purchased: bool = false:
	set(value):
		midboat_purchased = value
		if value:
			midboat_purchased_changed.emit()
