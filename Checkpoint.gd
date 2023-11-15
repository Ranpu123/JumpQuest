extends Area2D

@onready var is_active = false

func _ready():
	$AnimatedSprite2D.play("indle")

func _on_body_entered(body):
	if body.is_in_group("player") and !is_active:
		body.last_checkpoint = self.position
		is_active = true
		$AnimatedSprite2D.play("active")
