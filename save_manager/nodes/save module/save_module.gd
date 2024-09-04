extends Node2D
class_name save_module

#this class contains functions for triggering the save managers save/load functions
#as long as this is just a template, i dont think theres much else i can add here.
#cause each save system for each game is gonna be so different.
#an rpg will probably have dedicated points/ a file manager
#level based games probably will save automatically at points
#etc etc.
#so ill leave this as is


@onready var save_mi : save_manager = get_node("/root/save_manager_auto")


func save():
	save_mi.save_game()



