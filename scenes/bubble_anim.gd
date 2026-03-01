extends Node2D

@onready var timer: Timer = $Timer

var possible_times = [3, 4, 5, 6]
@onready var bubbles_sfx: AudioStreamPlayer = $BubblesSFX

func _ready(): 
	timer.wait_time = possible_times.pick_random() # pick a random time for the timer
	$Timer.start() 
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("bubbling")
	print("Timer end.")
	bubbles_sfx.play()
	await $AnimationPlayer.animation_finished
	timer.wait_time = possible_times.pick_random()
	timer.start()

func _process(delta: float):
	var secs_left = int(timer.time_left)
	#var last_second: int = -1 
	if secs_left > 0:
		if secs_left != int(secs_left):
			print(int(timer.time_left))

#
	#if timer.time_left > 0:
		#print(timer.time_left)
