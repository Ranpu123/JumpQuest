class_name AterrissarEnemy
extends State

@export var animator: AnimatedSprite2D
@export var lander_Timer: Timer

signal landed

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("falling")
	lander_Timer.start()

func _exit_state() -> void:
	set_physics_process(false)

func _on_timer_timeout():
	print("FINISHED LANDING")
	landed.emit()
