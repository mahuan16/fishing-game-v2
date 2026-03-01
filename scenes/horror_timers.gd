#extends Node2D
#
#@onready var horror_2: Sprite2D = $Horror2
#@onready var timer: Timer = $Timer
#
#
#func _ready():
	#randomize()
	#horror_2.visible = false
	#_set_random_timer()
#
#func _set_random_timer():
	#timer.wait_time = randf_range(2.0, 5.0) # random between 2 and 5 seconds
	#timer.start()
#
#func _on_Timer_timeout():
	#horror_2.visible = !horror_2.visible  # toggle visibility
	#_set_random_timer()
