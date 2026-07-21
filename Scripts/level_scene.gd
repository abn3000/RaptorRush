extends Node2D
@onready var feather_container: HBoxContainer = $FeatherContainer
@onready var feather_1: TextureRect = $FeatherContainer/Feather1
@onready var feather_2: TextureRect = $FeatherContainer/Feather2
@onready var feather_3: TextureRect = $FeatherContainer/Feather3
@onready var feather_4: TextureRect = $FeatherContainer/Feather4
@onready var feather_5: TextureRect = $FeatherContainer/Feather5
@onready var level: RichTextLabel = $Text/Level
@onready var timer: RichTextLabel = $Text/Timer
@onready var action: RichTextLabel = $Text/Action

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Timer(5.0)
	
	if Global.minigames_done < 3:
		Global.minigames_done = Global.minigames_done +1
		get_tree().change_scene_to_file("res://Scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	
	else:
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.lives:
		4:
			feather_1.hide()
		3:
			feather_1.hide()
			feather_2.hide()
		2:
			feather_1.hide()
			feather_2.hide()
			feather_3.hide()
		1:
			feather_1.hide()
			feather_2.hide()
			feather_3.hide()
			feather_4.hide()
		0:
			feather_container.hide()
	
	timer.text = str(time)
	level.text = "Level #" + str(Global.minigames_done+1)
	if Global.minigames_done == 0:
		action.text = "Collect!"
	elif Global.minigames_done == 1:
		action.text = "Click!"
	


func Timer(start_time: float):
	time = start_time
	
	while time > 0.1:
		await wait(0.1)
		time -= 0.1
	
	return

func wait(seconds:float) -> void:
	await get_tree().create_timer(seconds).timeout
