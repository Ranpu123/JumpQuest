extends Area2D

@onready var is_active = false
@export var prioridade = 0

func _ready():
	$AnimatedSprite2D.play("indle")

func _on_body_entered(body):
	if body.is_in_group("player") and !is_active:
		if(prioridade > body.last_prioridade):
			body.last_checkpoint = self.position
			body.last_prioridade = prioridade
		is_active = true
		$AnimatedSprite2D.play("active")
