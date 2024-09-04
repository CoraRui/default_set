extends Node2D
class_name music_player

#should have functions to call to play music. will probably work with a music_trigger node which i can put onto various stuff
#to trigger music changes and stuff.

#ok so in terms of how im storing the tracks, im thinking about doing some sort of parent thing where i store a track in each node.
#but thats a pain. i was originally just using dictionaries its just that a lot of times they're laggy asf.
#soo... ill use an array. it sucks that i cant just use by dictionary its just that i cant type dictionaries so 
#i need to just use my own type. i mean, im assuming thats what dictionaries do anyways, right? im not going to bother with
#efficient searches or anything though.
#i kind of want to write my own class for searching through arrays by looking for certain things. but...
#if im looking for something like a custom resource type, id have to look for a specific value in that resource.
#like with the music link, id have to look for that specific music link rather than for just an element in it to be equivalent.
#theres more to consider, but i think a thing like that would be more annoying work than i wanna do over something as simple as this.
#anyways.

#audiostreamplayer node that plays the music
@export var stream_player : AudioStreamPlayer
#array that holds all music tracks
@export var music_arr : Array[track]
#track that is returned by find_track if no track is found. might just be nothing idk
@export var fail_track : track

@onready var debug_i : debug = get_node("/root/debug_auto")

func play_track(ml : music_link) -> void:
	#TODO: check for same track? maybe restart on same track should be a parameter...
	#TODO: adjustment of volume/delay from music link
	stream_player.stream = find_track(ml).music_file
	if stream_player.stream != null:
		stream_player.play()

func pause_track() -> void:
	#pause the track at its current position so it can be restarted.
	stream_player.stream_paused = true

func start_track() -> void:
	#starts the track again if its just paused
	
	if stream_player.stream == null:
		debug_i.db_print("tried to start track with no current track", "mus_pla")
		return
		
	
func stop_track() -> void:
	#should just stop the track from playing and clear the stream
	stream_player.stop()
	stream_player.stream = null

func find_track(ml : music_link) -> track:
	for t in music_arr:
		if ml.name == t.track_name:
			return t
	
	print("couldn't find track: ", ml.track_name)
	return fail_track
