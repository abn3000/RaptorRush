extends Button


# Called when the node enters the scene tree for the first time.
func _on_pressed() -> void:
	Global.lives = 5
	Global.minigames_done = 0
	GlobalMusic.stream_paused = false
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
