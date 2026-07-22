extends Node2D

# This path looks inside the item to find its collision area
@onready var self_area = $Item/Area2D

# Define our two event signals
signal drop_collected
signal hit_by_meteor

# Configuration options you can change in the Inspector panel
@export var fall_speed: float = 300.0
@export var is_meteor: bool = false

func _process(delta: float) -> void:
	# Move the object down the screen every frame
	position.y += fall_speed * delta
	
	# Delete the item automatically if it falls off the bottom of the screen uncaught
	if position.y > 1000:
		queue_free()

# Triggered when an object collides with the player's CatchZone
func _on_area_2d_area_entered(area: Area2D) -> void:
	if self.visible:
		# Check if the item landed flat inside your CatchZone bucket
		if area.name == "CatchZone":
			if is_meteor:
				self_area.set_deferred("monitoring", false)
				self_area.set_deferred("monitorable", false)
				hit_by_meteor.emit() # Caught a hazard!
			else:
				drop_collected.emit() # Caught a scoring item!
				
			self.hide() # Turn invisible instantly on contact
