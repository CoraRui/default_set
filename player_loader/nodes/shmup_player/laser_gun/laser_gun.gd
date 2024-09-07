extends Node2D
class_name laser_gun

#this node handles shooting input and instantiates bullets.


@export var bullet_ref : PackedScene

@export var bullet_point : Node2D

#need a delay system for time between bullets, and bullet return
var shot_frame : int = 0				#if greater than 0, shot_delay isn't over
@export var shot_delay : int = 5		#frames between each shot

@export var shot_rem : int = 3;			#shots remaining
@export var shot_count : int = 3		#max number of shots out at once

#before, i had the bullet trigger a function in the laser gun to restore the bullet.
#i could just have references in here then check them. but that sounds inefficient.
#so yeah. from bullet

func _physics_process(_delta):
	
	if(Input.is_action_pressed("action_2")):
		shoot()
		
	inc_frames()
	
func shoot() -> void:
	#check for shot delay and count
	if shot_frame > 0 ||  shot_rem <= 0:
		#if not enough time since last shot
		return
	
	var new_bullet : laser_beam = bullet_ref.instantiate()
	get_tree().get_root().add_child.call_deferred(new_bullet)
	new_bullet.global_position = bullet_point.global_position
	new_bullet.laser_bi = self
	shot_frame = shot_delay
	
	shot_rem -= 1
	

func inc_frames() -> void:
	#increments delay cooldown if its active
	if shot_frame > 0:
		shot_frame -= 1

func return_bullet() -> void:
	shot_rem = clampi(shot_rem + 1, 0, shot_count)
	
