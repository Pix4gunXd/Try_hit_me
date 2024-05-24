extends Area2D

var travelled_distance = 0

var weapon = null #Verifica de qual arma esta sendo disparada para puxar o dano

func _physics_process(delta):
<<<<<<< HEAD
	const SPEED = 1500
	const RANGE = 1225
=======
	const SPEED = 1000
	const RANGE = 1200
>>>>>>> 92abd62b295770184464665bbbd19a0fb1c0b0c3
	
	var direction = Vector2.RIGHT.rotated(rotation) # RIGHT = x1/y0 MAKES THE BULLET GO STRAIGHT
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
	
	#Place it in damage.emit later
	if body.has_method("take_damage"):
		body.take_damage(weapon.dmg) #Take the dmg value of the weapon

