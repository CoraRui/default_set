extends Node2D
class_name collision_box

#TODO: all good. just remember to make local and set layermask on start

#this collision box should make collision between different objects a little easier.
#not being able to use the entire object is annoying, but making it local shouldnt be that bad.
#i mean, this is just a general way to set this up anyways.
#i want signals to be able to just connect from this node. meaning that i need signals on this node.

#handling of body/area
#just combine them, in the rare case that you do use body you usually need both. if for some reason you need
#separate, you cann add later, or else there will be clutter.



signal up_entered
signal up_exited
signal down_entered
signal down_exited
signal left_entered
signal left_exited
signal right_entered
signal right_exited


@export_group("collision areas")
@export var up_area : Area2D
@export var down_area : Area2D
@export var left_area : Area2D
@export var right_area : Area2D
@export_group("","")


#region enter/exit signals

func _on_up_area_area_entered(_area):
	up_entered.emit()

func _on_up_area_area_exited(_area):
	up_exited.emit()

func _on_down_area_area_entered(_area):
	down_entered.emit()

func _on_down_area_area_exited(_area):
	down_exited.emit()

func _on_left_area_area_entered(_area):
	left_entered.emit()

func _on_left_area_area_exited(_area):
	left_exited.emit()

func _on_right_area_area_entered(_area):
	right_entered.emit()

func _on_right_area_area_exited(_area):
	right_exited.emit()




func _on_up_area_body_entered(_body):
	up_entered.emit()

func _on_up_area_body_exited(_body):
	up_exited.emit()

func _on_down_area_body_entered(_body):
	down_entered.emit()

func _on_down_area_body_exited(_body):
	down_exited.emit()

func _on_left_area_body_entered(_body):
	left_entered.emit()

func _on_left_area_body_exited(_body):
	left_exited.emit()

func _on_right_area_body_entered(_body):
	right_entered.emit()

func _on_right_area_body_exited(_body):
	right_exited.emit()

#endregion
