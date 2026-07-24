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
		# Checking bucket
		if area.name == "CatchZone":
			if is_meteor:
				# The monitoring thing prevents double hits
				self_area.set_deferred("monitoring", false)
				self_area.set_deferred("monitorable", false)
				hit_by_meteor.emit()
			else:
				# Nice catch
				drop_collected.emit()
			self.hide()

		# Checking body
		elif area.name == "Hurtbox":
			if is_meteor:
				# Meteors still affect the body, but items dont get caught. Life's not fair.
				self_area.set_deferred("monitoring", false)
				self_area.set_deferred("monitorable", false)
				hit_by_meteor.emit()
				self.hide()
			else:
				pass
