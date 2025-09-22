extends StaticBody2D  # or Area2D

# Set your canvas size
@export var canvas_size: Vector2 = Vector2(1024, 768)

func _ready():
	# Define the four corners of the canvas

	$CollisionPolygon2D.polygon = [
		Vector2(0, 0),                               # Top-left
		Vector2(canvas_size.x, 0),                   # Top-right
		Vector2(canvas_size.x, canvas_size.y),       # Bottom-right
		Vector2(0, canvas_size.y)                    # Bottom-left
	]
