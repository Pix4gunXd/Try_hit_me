extends CharacterBody2D

@onready var enemy = preload("res://Enemies/Level_1/Bobot/e_bobot.tscn")

var life = 200.0

# Preload your weapon scenes
var weapon1_scene = preload("res://Weapons/Glock/pistol.tscn")
var weapon2_scene = preload("res://Weapons/Rifle/rifle.tscn")
var weapon3_scene = preload("res://Weapons/Shotgun/shotgun.tscn")

# Variable to hold the current weapon node
var current_weapon = null
var current_weapon_index = 1
var ammo_counts = {1: 12, 2: 21, 3: 8}  # Default ammo counts for each weapon

func _ready():
	switch_weapon(1)

func _input(event):
	if event.is_action_pressed("switch_weapon_1"):
		switch_weapon(1)
	elif event.is_action_pressed("switch_weapon_2"):
		switch_weapon(2)
	elif event.is_action_pressed("switch_weapon_3"):
		switch_weapon(3)
	
	if event.is_action_pressed("shoot") and current_weapon:
		current_weapon.shoot()
	if event.is_action_pressed("reload") and current_weapon:
		current_weapon.reload()

func switch_weapon(weapon_number):
	save_current_ammo()
	
	if current_weapon:
		current_weapon.queue_free()
	
	match weapon_number:
		1:
			current_weapon = weapon1_scene.instantiate()
		2:
			current_weapon = weapon2_scene.instantiate()
		3:
			current_weapon = weapon3_scene.instantiate()
	
	if current_weapon:
		add_child(current_weapon)
		current_weapon.position = Vector2.ZERO
		current_weapon.ammo = ammo_counts[weapon_number]
		current_weapon_index = weapon_number
	
	# Update the weapon image in the HUD
	$Hud.update_weapon_img(weapon_number)

func save_current_ammo():
	if current_weapon:
		ammo_counts[current_weapon_index] = current_weapon.ammo

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 500
	move_and_slide()
	
	walk_face()
	hud()

func walk_face():
	if velocity.length() > 0.0:
		$Null_C.play_walk_animation()
	else:
		$Null_C.play_idle_animation()
	
	if get_global_mouse_position().x < global_position.x:
		$Null_C.scale.x = -1
		if current_weapon:
			current_weapon.scale.x = -1
	else:
		$Null_C.scale.x = 1
		if current_weapon:
			current_weapon.scale.x = 1

func hud():
	if current_weapon:
		$Hud.update_ammo(current_weapon.ammo, current_weapon.max_ammo)
	$Hud.update_healthbar(life)

func take_damage(_dmg):
	pass
