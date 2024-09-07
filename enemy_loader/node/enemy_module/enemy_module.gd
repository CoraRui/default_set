extends Node2D
class_name enemy_module

#node that uses the enemy_loader autoload to spawn in an enemy pattern.

@export var send_onready : bool = false

@export var enemy_arr : Array[enemy_command]

@onready var enemy_li : enemy_loader = get_node("/root/enemy_loader_auto")

func _ready():
	if send_onready:
		send_pattern()

func send_pattern():
	enemy_li.send_pattern(enemy_arr)
