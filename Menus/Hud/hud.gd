extends CanvasLayer

# const weapon = preload(current_weapon) -> To change the ammo number according to the current weapon

func update_ammo(txt, max_ammo):
	$Ammo.text = str(txt, " / ", max_ammo )

func update_healthbar(health):
	$Health.value = health
