extends CharacterBody2D

@onready var enemy = preload("res://Enemies/Level_1/Bobot/e_bobot.tscn")

 #If you want to comment fast use Ctrl + K
var life = 200.0

func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")	
	velocity = direction * 500
	move_and_slide()
	
	walk_face() #Walk and face
	hud() # Constantly update HUD

func walk_face():
	if velocity.length() > 0.0:
		$Null_C.play_walk_animation()
	else:
		$Null_C.play_idle_animation()
	#-----------------------------------------------------------------------------------------------
	if get_global_mouse_position().x < global_position.x: 
		#Trocar o nome das armas como $Pistol por um node referente a todas as armas que cuide da troca delas!
		$Null_C.scale.x = -1  # Inverte o nó horizontalmente
		current_weapon.scale.x = -1
	else:
		$Null_C.scale.x = 1
		current_weapon.scale.x = 1

func hud():
	$Hud.update_ammo(current_weapon.ammo, current_weapon.max_ammo) #Trocar para .ammo da arma atual selecionada
	$Hud.update_healthbar(life)

func take_damage(_dmg):
	pass

# Preload your weapon scenes
var weapon1_scene = preload("res://Weapons/Glock/pistol.tscn")
var weapon2_scene = preload("res://Weapons/Rifle/rifle.tscn")
var weapon3_scene = preload("res://Weapons/Shotgun/shotgun.tscn")

# Preload your weapon images
var weapon1_image = preload("res://Weapons/Glock/glock_17_1.png")
var weapon2_image = preload("res://Weapons/Rifle/Rifle_01.png")
var weapon3_image = preload("res://Weapons/Shotgun/m1014 1.png")

# Variable to hold the current weapon node
var current_weapon = null

# Load the HUD scene
var hud_scene = preload("res://Menus/Hud/hud.tscn")
var hud_instance = null
var weapon_image_texture_rect = null

func _ready():
	# Instance the HUD scene and add it to the scene tree
	hud_instance = hud_scene.instantiate()
	add_child(hud_instance)
	
	# Get reference to the TextureRect node
	weapon_image_texture_rect = hud_instance.get_node("WeaponImage")
	
	switch_weapon(1) # Start with weapon 1 or any default weapon

func _input(event):
	if event.is_action_pressed("switch_weapon_1"):
		switch_weapon(1)
	elif event.is_action_pressed("switch_weapon_2"):
		switch_weapon(2)
	elif event.is_action_pressed("switch_weapon_3"):
		switch_weapon(3)

func switch_weapon(weapon_number):
	# Remove the current weapon if it exists
	if current_weapon:
		current_weapon.queue_free()
	
	# Instance the new weapon based on the number
	match weapon_number:
		1:
			current_weapon = weapon1_scene.instantiate()
			weapon_image_texture_rect.texture = weapon1_image
		2:
			current_weapon = weapon2_scene.instantiate()
			weapon_image_texture_rect.texture = weapon2_image
		3:
			current_weapon = weapon3_scene.instantiate()
			weapon_image_texture_rect.texture = weapon3_image
	
	# Add the new weapon as a child of the player
	if current_weapon:
		add_child(current_weapon)
		current_weapon.position = Vector2.ZERO # Adjust the position as necessary

#SIGNALS

