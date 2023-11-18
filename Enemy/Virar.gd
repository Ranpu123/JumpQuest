class_name VirarEnemy
extends State

@export var animator: AnimatedSprite2D
@export var actor: Enemy1
@export var down_cast: RayCast2D

signal turned

func _ready():
	set_physics_process(false)
	
func _enter_state():
	actor.dir *= -1
	down_cast.position.x *= -1
	animator.flip_h = true if actor.dir == 1 else false 
		
		
	turned.emit()

