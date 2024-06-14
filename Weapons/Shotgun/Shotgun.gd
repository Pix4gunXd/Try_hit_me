extends Area2D

const SHOTGUN = preload("res://Sounds/Weapons/Shotgun.mp3")
const SHOTGUN_RELOAD = preload("res://Sounds/Weapons/shotgun-reload.mp3")

var max_ammo = 6 #Lembrando de caso queira mudar a munição, também deve mudar no player as munições bases de cada arma!
var ammo = max_ammo
var dmg = 8
var is_reloading = false

func _process(delta):
	%Marker2D.look_at(get_global_mouse_position())

func shoot():
	if ammo == 0:
		reload()
	
	if is_reloading or ammo <= 0:
		return
	
	
	
	SfxSounds.play_sound(SHOTGUN)
	
	const BULLET = preload("res://Weapons/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	new_bullet.dmg = dmg  # Assign weapon damage to the bullet
	
	get_tree().root.add_child(new_bullet)  # Add to scene root or a dedicated node
	
	var angle_offset = deg_to_rad(4.5) # 15 degrees in radians
	for i in range(3): # 3 bullets above
		var new_bullet_above = BULLET.instantiate()
		new_bullet_above.global_position = %ShootingPoint.global_position
		new_bullet_above.global_rotation = %ShootingPoint.global_rotation + angle_offset * (i + 1)
		
		new_bullet_above.dmg = dmg  # Assign weapon damage to the bullet
		
		get_tree().root.add_child(new_bullet_above)  # Add to scene root or a dedicated node
	
	for i in range(3): # 3 bullets below
		var new_bullet_below = BULLET.instantiate()
		new_bullet_below.global_position = %ShootingPoint.global_position
		new_bullet_below.global_rotation = %ShootingPoint.global_rotation - angle_offset * (i + 1)
		
		new_bullet_below.dmg = dmg  # Assign weapon damage to the bullet
		
		get_tree().root.add_child(new_bullet_below)  # Add to scene root or a dedicated node
	
	$AnimationPlayer.play("shoot")
	
	ammo -= 1

func reload():
	if is_reloading or ammo == max_ammo:
		return
	
	SfxSounds.play_sound(SHOTGUN_RELOAD)
	
	is_reloading = true
	%Reload_timer.start()
	%AnimationPlayer.play("reload")

# SIGNALS

func _on_reload_timer_timeout():
	is_reloading = false
	ammo = max_ammo
	SfxSounds.stop()
