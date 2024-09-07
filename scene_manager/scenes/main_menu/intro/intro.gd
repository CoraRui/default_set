extends Node2D
class_name intro_scene


@export var title_link : scene_link 

#region autoloads

@onready var text_bi : text_box = get_node("/root/text_box_auto")
@onready var scene_mi : scene_manager = get_node("/root/scene_manager_auto")

#endregion

func _ready():
	pass

func _input(_event):
	if Input.is_action_just_pressed("action"):
		scene_mi.load_scene(title_link)

