extends AudioStreamPlayer


func play_sound(stream: AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream

	instance.bus = "Sfx"
	add_child(instance)
	instance.play()

func play_sfx(sound: AudioStream, parent: Node):
	if sound != null and parent != null:
		var stream = AudioStreamPlayer.new()
		
		stream.stream = sound
		
		
		parent.add_child(stream) 
		stream.play()
	


#Funções sfx
