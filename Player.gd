extends CharacterBody2D

signal hit

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

	move_and_slide()
	
	update_animation()

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
	$AnimatedSprite2D.animation = "walk"
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION) 
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

#collision -> player death
func _on_input_event(viewport, event, shape_idx):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
