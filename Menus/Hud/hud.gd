extends CanvasLayer

func update_ammo(txt, max_ammo):
	%Ammo.text = str(txt, " / ", max_ammo )

func update_healthbar(health):
	$Health.value = health
