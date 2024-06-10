extends CanvasLayer

# Preload your weapon images
var weapon1_image = preload("res://Weapons/Glock/glock_17_1.png")
var weapon2_image = preload("res://Weapons/Rifle/Rifle_01.png")
var weapon3_image = preload("res://Weapons/Shotgun/m1014_1.png")

var weapon_image_texture_rect = null

func _ready():
	weapon_image_texture_rect = get_node("WeaponImage")

func update_ammo(txt, max_ammo):
	%Ammo.text = str(txt, " / ", max_ammo )

func update_healthbar(health):
	$Health.value = health

func update_weapon_img(weapon_index):
	match weapon_index:
		1:
			weapon_image_texture_rect.texture = weapon1_image
			weapon_image_texture_rect.flip_h = true
		2:
			weapon_image_texture_rect.texture = weapon2_image
			weapon_image_texture_rect.flip_h = false
		3:
			weapon_image_texture_rect.texture = weapon3_image
			weapon_image_texture_rect.flip_h = true
