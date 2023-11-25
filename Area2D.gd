extends Area2D

func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("coinListener", "_on_coin_up")
		self.queue_free()
		
