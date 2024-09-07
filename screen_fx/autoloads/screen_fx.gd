extends Node2D
class_name screen_fx


#TODO: should probably do some stuff to this, not entirely sure how ready this is.

@export var screen_rect : ColorRect					#white colorRect covering the whole screen

#fade to white
var fading : bool = false
var fade_delta : int = 0

func _physics_process(_delta):
	if fading:
		fade_process()
	
func fade_process() -> void:
	if screen_rect.color.a8 < 255:
		screen_rect.color.a8 += fade_delta

func fade_to_white(delta : int) -> void:
	#delta is the amount to increase the a8 each frame
	fading = true
	fade_delta = delta
	
func clear_rect():
	screen_rect.color.a8 = 0
	fading = false
