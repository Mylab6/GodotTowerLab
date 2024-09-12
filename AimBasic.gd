extends Node3D

@export var projectile_scene: PackedScene  # Add the projectile scene
@export var fire_rate: float = 1.0         # Time between each shot
@export var projectile_speed: float = 50.0 # Speed of the projectile

var time_since_last_shot: float = 0.0      # Timer to track time between shots

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Function to find the first target in a specific group (e.g., "tanks").
func get_from_group(tag: String) -> Node3D:
	var targets = get_tree().get_nodes_in_group(tag)
	
	# Check if there are any targets
	if targets.size() > 0:
		# Get the first target in the group
		var target = targets[0]
		return target
	else:
		print("No targets found in the group.")
		return null

# Function to launch a projectile
func launch_projectile(target: Node3D) -> void:
	if target == null:
		return

	# Instance the projectile
	var projectile = projectile_scene.instantiate()

	# Add the projectile to the scene first before modifying its transform
	get_tree().root.add_child(projectile)

	# Set the projectile’s position to this node’s position
	projectile.global_transform.origin = global_transform.origin

	# Make the projectile face the target by using look_at()
	projectile.look_at(target.global_transform.origin, Vector3.UP)

	# Apply velocity to the projectile in the forward direction
	var direction = (target.global_transform.origin - global_transform.origin).normalized()
	projectile.apply_impulse(Vector3.ZERO, direction * projectile_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_shot += delta

	# Get the first target from the group "tanks"
	var target = get_from_group("tanks")
	
	if target:
		# Look at the target
		look_at(target.global_transform.origin, Vector3.UP)

		# Check if enough time has passed to fire another projectile
		if time_since_last_shot >= fire_rate:
			# Fire the projectile toward the target
			launch_projectile(target)

			# Reset the time since last shot
			time_since_last_shot = 0.0
