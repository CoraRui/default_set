extends Node2D
class_name sword

#best way would probably be to just have a directional pointer that updates from the player, then when the swing input is pressed, just
#place the sword in that area. jus gotta turn it or whatever.


@export var sword_spots : Array[Node2D]

@export var sword_node : Node2D



func _input(event):
	if event.is_action_pressed("action"):
		swing()

func swing():
	#places the sword, activates a timer which will deactivate the sword/unfreeze the player after a certain amount of time.
	sword_node.set_visible(true)
	
	


