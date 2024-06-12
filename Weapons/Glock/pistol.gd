extends Area2D

const SHOOT_SFX = preload("res://Sounds/Weapons/gun-shot-1.mp3")

var max_ammo = 12
var ammo = max_ammo
var dmg = 15
var is_reloading = false

func _physics_process(_delta):
	%Marker2D.look_at(get_global_mouse_position())

func shoot():
	if is_reloading or ammo <= 0:
		return
	
	SfxHandler.play_sfx(SHOOT_SFX, self)
	
	const BULLET = preload("res://Weapons/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	new_bullet.dmg = dmg  # Assign weapon damage to the bullet
	
	get_tree().root.add_child(new_bullet)  # Add to scene root or a dedicated node
	
	$AnimationPlayer.play("shoot")
	ammo -= 1

func reload():
	if is_reloading or ammo == max_ammo:
		return
	
	is_reloading = true
	%Reload_timer.start()
	%AnimationPlayer.play("reload")

# SIGNALS

func _on_reload_timer_timeout():
	is_reloading = false
	ammo = max_ammo
