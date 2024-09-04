extends Resource
class_name save_file

#contains info for the main save file

@export var player_name : String = "cora"		#name of person playing game

@export var health : int = 10					#current health idk whatever

#converts this file to a dictionary
func this_to_dict() -> Dictionary:
	#converts this save_file into dictionary format
	var new_dict : Dictionary = {
		"player_name" : player_name,
		"health" : health,
		
	}
	
	return new_dict

#static file conversions
static func dict_to_file(sd : Dictionary) -> save_file:
	#this function doesnt do anything with the current save file, its just a static overall function
	var new_file : save_file = save_file.new()
	
	new_file.player_name = sd["player_name"]
	new_file.health = sd["health"]
	
	return new_file
	
static func file_to_dict(sf : save_file) -> Dictionary:
	var new_dict : Dictionary = {
		"player_name" : sf.player_name,
		"health" : sf.health,	
	}
	
	return new_dict

func print_file() -> void:
	var sd : Dictionary = this_to_dict()
	
	for k in sd.keys():
		print(k," : ", sd[k])
	
	
