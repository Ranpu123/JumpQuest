extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if body.has_method("_on_power_up_activate"):
		body._on_power_up_activate()
		self.queue_free()
   
