extends Node3D

var speed = 2.0  # Movement speed
var distance = 2.0  # Distance to move in each direction
var start_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("tanks")
	start_position = global_transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Calculate the new x position using a sine wave
	var offset = sin(Time.get_ticks_msec() / 1000.0 * speed) * distance
	
	# Update the position
	global_transform.origin = start_position + Vector3(offset, 0, 0)
