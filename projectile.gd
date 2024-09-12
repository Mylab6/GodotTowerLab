extends RigidBody3D

# Speed of the projectile
@export var speed: float = 50.0
# Time before the projectile is destroyed
@export var lifetime: float = 3.0

# Timer for tracking how long the projectile has existed
var _time_passed: float = 0.0

func _ready():
	pass
	# Optionally set the mode to static or kinematic depending on your game logic
	#self.mode = RigidBody3D.Mode.KINEMATIC

func _process(delta: float):
	_time_passed += delta
	
	# Move the projectile forward along its local Z axis (forward direction)
	global_transform.origin += -global_transform.basis.z * speed * delta

	# Destroy the projectile if its lifetime is exceeded
	if _time_passed >= lifetime:
		queue_free()

# Handle collision with other objects
func _on_body_entered(body: Node):
	# Destroy the projectile on collision, you can also trigger other effects here
	queue_free()
