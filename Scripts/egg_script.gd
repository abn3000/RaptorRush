extends Node2D

@onready var self_area = $Egg/Area2D

# make a signal
signal egg_collected

# This listens for collisions automatically without looking for hardcoded paths!
func _on_area_2d_area_entered(area: Area2D) -> void:
	if self.visible:
		egg_collected.emit() 
		self.hide()          
