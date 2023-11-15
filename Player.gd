extends CharacterBody2D

signal hit

@onready var animation = $AnimatedSprite2D

const MAX_SPEED = 250.0
const ACCELERATION = 15.0
const JUMP_VELOCITY = -350.0
const FRICTION = 10.0

var has_double_jumped = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	apply_gravity(delta)

	handle_jump()
	
	handle_double_jump()

	handle_movement()
	
	update_animation()
	
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_double_jump():
	if is_on_floor() and has_double_jumped:
		has_double_jumped = false
	
	if Input.is_action_just_pressed("move_jump") and (not has_double_jumped and not is_on_floor()):
		has_double_jumped = true
		velocity.y = JUMP_VELOCITY * 0.85
		
func handle_jump():
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func handle_movement():
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION) 
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

func update_animation():
	if velocity.x > 0:
		animation.flip_h = true
	elif velocity.x < 0:
		animation.flip_h = false
	
	if velocity.length() > 0:
		if velocity.x != 0 and is_on_floor():
			animation.play("walking")
		elif velocity.y != 0:
			animation.play("falling")
	else:
		animation.play("idle")

#collision -> player death
func _on_input_event(viewport, event, shape_idx):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
