extends Node2D
class_name music_player

#contains functions to play music using the music_link resource type.
#plays one track at a time. playing a new track will start a different track.

#TODO: needs more work
#TODO: transitions between songs.


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
	
	var new_track : AudioStreamOggVorbis = find_track(ml).music_file
	
	if stream_player.stream != null && stream_player.stream != new_track :
		stream_player.stream = new_track
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
