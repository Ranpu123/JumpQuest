class_name AndarEnemy
extends State

@export var down_cast: RayCast2D
@export var animator: AnimatedSprite2D
@export var actor: Enemy1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal next_border

func _ready():
	set_physics_process(false)
	
func _enter_state():
	set_physics_process(true)
	animator.play("walk")

func _exit_state():
	set_physics_process(false)

func _physics_process(delta):
	if (not down_cast.is_colliding() and actor.is_on_floor()) or actor.is_on_wall():
		next_border.emit()
	
	if not actor.is_on_floor():
		actor.velocity.y += gravity * delta
	
	actor.velocity.x = actor.dir * actor.MAX_SPEED
	actor.move_and_slide()
