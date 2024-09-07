extends Node2D

#this autoload has a library of special effects kinda nodes on hand that it can spawn in using the
#place_fx command. theyre usually just nodes... they'll be placed by position passed in.

#TODO: need to add some default fx to this, other than that the fx will probably be made on the spot

@export var fx_arr : Array[fx_ref]

@export var fail_ref : fx_ref


func place_fx(l : fx_link):
	
	var fx : fx_ref = find_fx(l)
	
	var new_fx : Node2D = fx.ref.instantiate()
	
	get_tree().get_root().add_child.call_deferred()
	
	new_fx.global_position = l.fx_position
	
	
	

func find_fx(l : fx_link) -> fx_ref:
	for f in fx_arr:
		if f.name == l.name:
			return f
		
	return fail_ref
