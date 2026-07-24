extends Node2D

@onready var fullscreen_button: CheckButton = $FullScreenButton
@onready var music_button: CheckButton = $MusicButton

var music_bus_index: int = 0

func _ready() -> void:
	music_bus_index = 0
	
	
	var current_mode = DisplayServer.window_get_mode()
	fullscreen_button.button_pressed = (current_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
	
	# If it's not muted, the button's on!
	music_button.button_pressed = not AudioServer.is_bus_mute(music_bus_index)


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_music_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(music_bus_index, not toggled_on)



func _on_full_screen_button_toggled(toggled_on: bool) -> void:
	pass 
