class_name SubirEnemy
extends State

@export var animator: AnimatedSprite2D
@export var actor: Enemy2

signal back_in_place

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	if actor.position.y < actor.startPosition.y:
		actor.velocity = Vector2.ZERO
		back_in_place.emit()
	print("GOING UP")
	print("SPEED ", actor.velocity)

	actor.velocity.y += actor.UP_SPEED * delta
	actor.velocity.y = clamp(actor.velocity.y, 0, actor.UP_MAX_SPEED)
	actor.move_and_collide(actor.velocity)
