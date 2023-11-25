class_name CairEnemy
extends State

@export var down_cast: RayCast2D
@export var animator: AnimatedSprite2D
@export var actor: Enemy2
@export var down_sound: AudioStreamPlayer2D

signal hit_ground

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("falling")

func _exit_state() -> void:
	set_physics_process(false)
	down_sound.play()
	get_tree().call_group("camera", "_on_collision")

func _physics_process(delta):
	actor.velocity.y += actor.DOWN_ACCELERATION * delta
	actor.velocity.y = clamp(actor.velocity.y, 0,actor.DOWN_MAX_SPEED)
	var col = actor.move_and_collide(actor.velocity)
	
	if col:
		print("COLLIDED")
		actor.velocity = Vector2.ZERO
		hit_ground.emit()
