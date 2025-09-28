extends RigidBody2D

# Movement speed (linear)
@export var bullet: PackedScene
@export var speed: float = 200


func _ready():
	gravity_scale = 0


func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Capture input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


	# Apply movement
	linear_velocity = input_vector * speed
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()
		

func shoot_bullet():
	
		var bullet_instance = bullet.instantiate()
		var spawn_offset = transform.y * -70  # Negative so it spawns "forward" instead of behind
		bullet_instance.global_transform.origin = global_transform.origin + spawn_offset
		bullet_instance.rotation = rotation
		
		get_parent().add_child(bullet_instance)
	
		
		
	
