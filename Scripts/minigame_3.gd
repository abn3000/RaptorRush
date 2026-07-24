extends Node2D

@onready var themed_timer = $ThemedTimer

# I found a way to make random items spawn in repeatedly with preload
@onready var egg_scene = preload("res://Scenes/egg.tscn")
@onready var bone_scene = preload("res://Scenes/bone.tscn")
@onready var turtle_scene = preload("res://Scenes/turtle.tscn")
@onready var meteor_scene = preload("res://Scenes/meteor.tscn")
@onready var caught: RichTextLabel = $Caught


var score = 0
var timer_end = false

func _ready() -> void:
	# Start spawning continuously 
	start_spawner_loop()
	
	# Timer setup
	await themed_timer.Timer(17.0)
	timer_end = true
	check_end_conditions()

# This loop runs in the background spawning objects every 1 second
func start_spawner_loop() -> void:
	while not timer_end:
		await get_tree().create_timer(1.0).timeout
		if not timer_end:
			spawn_random_item()

# Generates a random item at a random spot across the top of the sky
func spawn_random_item() -> void:
	var choice = randi_range(1, 4)
	var new_item
	
	# Basically just make a new item from the scenes for each
	if choice == 1: new_item = egg_scene.instantiate()
	elif choice == 2: new_item = bone_scene.instantiate()
	elif choice == 3: new_item = turtle_scene.instantiate()
	else: new_item = meteor_scene.instantiate()
	
	if choice == 4:
		new_item.hit_by_meteor.connect(player_hit)
	else:
		new_item.drop_collected.connect(item_caught)
		
	# Spawn it just above the top of the screen at a random X coordinate
	new_item.global_position = Vector2(randf_range(150, 1000), -100)
	
	# Add the fresh falling copy directly into your level layout
	add_child(new_item)

# Triggered when an egg, bone, or turtle is caught successfully
func item_caught() -> void:
	score += 1
	print("Caught: ", score)
	caught.text = "Caught: " + str(score) + "/10"
	if score >= 10:
				if Global.minigames_done == 3:
					GlobalMusic.stream_paused = true
					get_tree().call_deferred("change_scene_to_file", "res://Scenes/done_screen.tscn")
					
				else:
					get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")

# Triggered when a meteor hits
func player_hit() -> void:
	Global.lives -= 1
	Global.minigames_done -= 1
	# Lose! 
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")

# When time runs out
func check_end_conditions() -> void:
	if score < 10:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")
