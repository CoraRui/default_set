extends Node2D

#this node just sits on the root node and performs intial functions. the most important part is just the ready.
#i feel like most of the time, all its ever going to do is use the scene manager to load the title/intro or whatever
#the way you actually do that is just by manually writing things into this script using the autoloads or whatever else

@export var init_scene : scene_link

@onready var scene_mi : scene_manager = get_node("/root/scene_manager_auto")
@onready var debug_i : debug = get_node("/root/debug_auto")
@onready var app_mi : app_manager = get_node("/root/app_manager_auto")
@onready var screen_fi : screen_fx = get_node("/root/screen_fx_auto")
@onready var text_bi : text_box = get_node("/root/text_box_auto")

func _ready():
	scene_mi.load_scene(init_scene)
	
	
	
