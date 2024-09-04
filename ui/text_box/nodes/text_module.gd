extends Node2D
class_name text_module

#node with basic text command functions. holds an array of text commands, which consist of a String and a dictionary containing
#parameters for that function.

#but how are those commands triggered? i should try to have those things in the commands themself. but do i want that handled here, 
#or in the text_box?

#i could have this node hold the array of Strings + dictionaries, then just pass that to the text_box. then the text box 
#could handle the rest. i just have to figure out what the trigger for that is.

#honestly i could just leave it like this and just connect a signal to this node and call the pass commands function from it.
#that should work for now.

@export var send_on_ready : bool = false

@export var c_set : Array[command_set]

@onready var text_bi : text_box = get_node("/root/text_box_auto")

func _ready():
	pass_commands()

func pass_commands():
	text_bi.send_commands(c_set)
