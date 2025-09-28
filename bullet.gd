extends StaticBody2D

func _ready():
	var shape = $CollisionShape2D.shape as CapsuleShape2D
	
	var radius = shape.radius
	var height = shape.height

	# Make a rectangle the size of the capsule
	var poly = Polygon2D.new()
	poly.polygon = [
		Vector2(-radius, -height / 2),
		Vector2(radius, -height / 2),
		Vector2(radius, height / 2),
		Vector2(-radius, height / 2)
	]
	poly.color = Color(0.65, 0.32, 0.17, 0.5)
	add_child(poly)

	
func _process(delta: float) -> void:
	position -= transform.y * 600 *delta
