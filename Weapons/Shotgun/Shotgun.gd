extends Area2D

var max_ammo = 8
var ammo = max_ammo
var dmg = 5
var is_reloading = false

func _physics_process(delta):
	%Marker2D.look_at(get_global_mouse_position())

func _unhandled_input(event):
	if event.is_action_pressed("reload"):
		reload()
		
	if event.is_action_pressed("shoot") and ammo > 0:
		shoot()

func shoot():
	if is_reloading:
		return
	
	const BULLET = preload("res://Weapons/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	new_bullet.weapon = self
	
	%ShootingPoint.add_child(new_bullet)
	
	var angle_offset = deg_to_rad(4.5) # 15 degrees in radians
	for i in range(3): # 3 bullets above
		var new_bullet_above = BULLET.instantiate()
		new_bullet_above.global_position = %ShootingPoint.global_position
		new_bullet_above.global_rotation = %ShootingPoint.global_rotation + angle_offset * (i + 1)
		
		new_bullet_above.weapon = self
		
		%ShootingPoint.add_child(new_bullet_above)
	
	for i in range(3): # 3 bullets below
		var new_bullet_below = BULLET.instantiate()
		new_bullet_below.global_position = %ShootingPoint.global_position
		new_bullet_below.global_rotation = %ShootingPoint.global_rotation - angle_offset * (i + 1)
		
		new_bullet_below.weapon = self
		
		%ShootingPoint.add_child(new_bullet_below)
	
	ammo -= 1

func reload():
	if is_reloading or ammo == max_ammo:
		return # Se estiver carregando ou ammo = max_ammo não realiza a func
	
	is_reloading = true
	%Reload_timer.start()
	
	%AnimationPlayer.play("reload")

# SIGNALS

func _on_reload_timer_timeout(): # Ao encerrar o Timer
	ammo = max_ammo
	is_reloading = false

