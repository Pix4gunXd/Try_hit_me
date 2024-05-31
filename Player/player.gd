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
		$Pistol.scale.x = -1
		$rifle.scale.x = -1
	else:
		$Null_C.scale.x = 1
		$Pistol.scale.x = 1
		$rifle.scale.x = 1

func hud():
	$Hud.update_ammo($Pistol.ammo, $Pistol.max_ammo) #Trocar para .ammo da arma atual selecionada
	$Hud.update_healthbar(life)

func take_damage(_dmg):
	pass

#SIGNALS

