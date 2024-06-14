extends Area2D

var travelled_distance = 0
var dmg = null  # Damage value assigned at instantiation

func _physics_process(delta):
	const SPEED = 2000
	const RANGE = 1200
	
	var direction = Vector2.RIGHT.rotated(rotation) # RIGHT = x1/y0 MAKES THE BULLET GO STRAIGHT
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	
	# Apply damage if the body has the take_damage method
	if body.has_method("take_damage"):
		body.take_damage(dmg) # Use the dmg value set when the bullet was instantiated
