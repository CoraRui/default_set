extends Node2D
class_name laser_beam


#thinking about the "bullet wall" on the top of the screen. 1 i maybe shouldnt have it cause then bullets return too fast.
#2, it can just be in the level

@export var vel_vec : Vector2i = Vector2i(0,-3)

@export var skip_vec : Vector2i = Vector2i(1,1)

@export var laser_bi : laser_gun

@export var clear_timer : Timer

@export var frame_index : int = 0
@export var frame_cap : int = 100

func _physics_process(_delta):
	move()
	inc_index()
	

func move():
	if frame_index % skip_vec.x == 0:
		global_position.x += vel_vec.x
	if frame_index % skip_vec.y == 0:
		global_position.y += vel_vec.y
	
func inc_index():
	frame_index = cmath.cycle_int(frame_index + 1, 0, frame_cap)
	
func clear():
	laser_bi.return_bullet()
	queue_free()


func _on_clear_timer_timeout():
	clear()

func _on_laser_hitarea_area_entered(_area):
	clear()
