extends RigidBody2D

# Movement speed (linear)
@export var speed: float = 200
# Rotation speed (radians per second)
@export var rotation_speed: float = 5.0
@export var bullet_speed: float = 500
@export var bullet_radius: float = 10.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Capture input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Normalize to prevent faster diagonal movement
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		
		# Target rotation based on input direction
		var target_rotation = input_vector.angle()
		
		# Smoothly interpolate rotation toward target
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)

	# Apply movement
	linear_velocity = input_vector * speed
	if Input.is_action_just_pressed("ui_accept"):  # Space by default
		shoot_bullet()
	
func shoot_bullet():
	# Create bullet as Area2D
	var bullet = Area2D.new()
	bullet.position = global_position
	bullet.rotation = rotation

	# Collision shape
	var collision_shape = CollisionShape2D.new
	var capsule = CapsuleShape2D.new()
	capsule.radius = bullet_radius
	capsule.height = bullet_radius * 2
	collision_shape.shape = capsule
	bullet.add_child(collision_shape)

	# Sprite for visualization
	var sprite = Polygon2D.new()
	sprite.polygon = [
		Vector2(-bullet_radius, -bullet_radius),
		Vector2(bullet_radius, -bullet_radius),
		Vector2(bullet_radius, bullet_radius),
		Vector2(-bullet_radius, bullet_radius)
	]
	sprite.color = Color(1, 1, 0)
	sprite.z_index = 1
	bullet.add_child(sprite)

	# Add to scene
	get_tree().get_current_scene().add_child(bullet)

	# Move bullet manually every frame
	bullet.set_physics_process(true)
	bullet._physics_process = func(delta):
		bullet.position += Vector2.RIGHT.rotated(rotation) * bullet_speed * delta


	# Auto-remove when offscreen
	#var notifier = VisibilityOnScreenNotifier2D.new()
	#notifier.rect = Rect2(Vector2.ZERO, Vector2(10,10))
	#bullet.add_child(notifier)
	#notifier.connect("screen_exited", bullet, "queue_free")
