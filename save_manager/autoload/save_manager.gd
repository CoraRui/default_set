extends Node2D
class_name save_manager

#this autoload shoud have functions for saving/loading from save files.
#how to save and how to save to specific locations? i know you essentially save everything to a dictionary,
#then serialize it. i dont remember the specifics. i know theres also some ResourceSaver class, but for some reason
#i dont want to use it... yeah cause its unsafe. anyways. i could make some kind of resource, then just put a dictionary
#into it and just use that as the save file. but how many save files will there be? do i need separate save files for
#multiple things? :I lets just figure out the basics first...


@export var file_01 : save_file			#main save file

@export_dir var file_dir : String = "user://savegame.save"

#region autoloads

@onready var debug_i : debug = get_node("/root/debug_auto")

#endregion

func _ready():
	if !load_game():
		file_01 = save_file.new()

func dict_to_file(sd : Dictionary) -> save_file:
	#converts the passed dictionary into save_file format
	var new_file : save_file = save_file.new()
	
	new_file.player_name = sd["player_name"]
	new_file.health = sd["health"]
	
	return new_file
	
func save_game() -> void:
	#saves the current save file in file 01 to the desired user directory
	var file_access : FileAccess = FileAccess.open(file_dir, FileAccess.WRITE)

	#convert the save_file to a dictionary then
	var json_string : String = JSON.stringify(file_01.this_to_dict())

	#stores the string representing the dictionary in the desired location
	file_access.store_line(json_string)
	
func load_game() -> bool:
	#this function checks the desired directory
	if not FileAccess.file_exists(file_dir):
		debug_i.db_print("save file isnt in expected location", "sav_man")
		return false
	
	var file_access : FileAccess = FileAccess.open(file_dir, FileAccess.READ)
	
	var dict_line : String = file_access.get_line()
	
	var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
	var parse_result = json.parse(dict_line)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", dict_line, " at line ", json.get_error_line())
		return false

		# this is the dictionary loaded from the file i think???
	var load_dict = json.get_data()

	file_01 = save_file.dict_to_file(load_dict)
	
	return true
	
	
	
	
	
	
	
	
	
	

