extends Control

const SHOOT_SFX = preload("res://Sounds/Weapons/gun-shot-1.mp3")

@onready var audio_name_lbl = $HBoxContainer/Audio_name_lbl as Label
@onready var audio_num_lbl = $HBoxContainer/Audio_Num_lbl as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider


@export_enum("Master", "Music", "Sfx") var bus_name : String 

var bus_index : int = 0

func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()

func set_name_label_text() -> void:
	audio_name_lbl.text = str(bus_name) + " Volume" #Muda o nome da label para o nome do audio_bus selecionado como MasterVolume ou MusicVolume

func set_audio_num_label_txt() -> void:
	audio_num_lbl.text = str(h_slider.value * 100) #+ "%" to place % after the sound #str() converte para string


func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name) 


func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_txt()

func on_value_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) #Linear_to_db change linear energy to decibels (audio) to implement Sliders behave as expected
	set_audio_num_label_txt()


func _on_button_pressed():
	SfxHandler.play_sfx(SHOOT_SFX, self)
