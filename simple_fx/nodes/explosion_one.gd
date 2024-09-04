extends Node2D
class_name explosion_one

#ok. so do i want to have a bunch of different explosion animations loaded into this?
#i think i should just start making it. i can think about more fancy stuff later.

#anyways. its going to have a timer, animsprite, and NO streamplayer

@export var clear_timer : float = 0.5:
	get:
		return clear_timer
	set(value):
		clear_timer = value
		exp_timer.wait_time = value


@export var exp_timer : Timer 

@export var anim : AnimatedSprite2D


func clear():
	queue_free()



func _on_exp_timer_timeout():
	clear()
