class_name FlutuarEnemy
extends State

@export var down_cast: RayCast2D
@export var animator: AnimatedSprite2D
@export var actor: Enemy2

signal player_under

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	if down_cast.is_colliding():
		var colission = down_cast.get_collider()
		if colission.is_in_group("player"):
			print("UNDER")
			player_under.emit()
