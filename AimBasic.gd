extends CSGMesh3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_from_group(tag)-> Node3D:
	
	var targets = get_tree().get_nodes_in_group(tag)
	
	# Check if there are any targets
	if targets.size() > 0:
		# Get the first target in the group
		var target = targets[0]
		return target
		# Look at the target
		#look_at(target.global_transform.origin, Vector3.UP)
	else:
		print("No targets found in the group.")
		return null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_from_group("tanks")
	look_at(target.global_transform.origin, Vector3.UP)
	
