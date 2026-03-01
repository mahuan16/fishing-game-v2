extends Node2D

@onready var timer: Timer = $Timer


var possible_times = [3, 4, 5, 6]

func _ready(): 
	timer.wait_time = possible_times.pick_random() # pick a random time for the timer
	$Timer.start() 
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("bubbling")
	print("Timer end.")
	await $AnimationPlayer.animation_finished
	timer.wait_time = possible_times.pick_random()
	timer.start()

func _process(delta: float):
	if timer.time_left > 0:
		print(timer.time_left)
