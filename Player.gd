extends CharacterBody2D

signal hit

@onready var animation = $AnimatedSprite2D
@onready var last_checkpoint = self.position
@onready var last_prioridade = 0

var MAX_SPEED = 250.0
const ACCELERATION = 20.0
var JUMP_VELOCITY = -350.0
const FRICTION = 10.0

var has_double_jumped = false
var died = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	apply_gravity(delta)
	
	if !died:
		handle_jump()
		
		handle_double_jump()
		
		handle_wall_jump()

		handle_movement()
		
	update_animation()
	
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_double_jump():
	if (is_on_floor() or is_on_wall()) and has_double_jumped:
		has_double_jumped = false
	
	if Input.is_action_just_pressed("move_jump") and (not has_double_jumped and not (is_on_floor() or is_on_wall())):
		$JumpSound.play()
		has_double_jumped = true
		velocity.y = JUMP_VELOCITY * 0.85
		
func handle_jump():
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		$JumpSound.play()
		velocity.y = JUMP_VELOCITY
		
func handle_wall_jump():
	if Input.is_action_just_pressed("move_jump"):
		
		if Input.is_action_pressed("move_right") and is_on_wall_only():
			$JumpSound.play()
			velocity.y = JUMP_VELOCITY * 0.75
			velocity.x = JUMP_VELOCITY * 0.50
		if Input.is_action_pressed("move_left") and is_on_wall_only():
			$JumpSound.play()
			velocity.y = JUMP_VELOCITY * 0.75
			velocity.x = -JUMP_VELOCITY * 0.50
	

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

func _on_player_detector_body_entered(body):
	player_die(body)
		

#Ready to Respawn GAMER
func _on_respawn_timer_timeout():
	self.position = last_checkpoint
	$CollisionShape2D.disabled = false
	_rest_velocity()
	show()
	died = false

func _rest_velocity():
	velocity = Vector2.ZERO

func player_die(body):
	if body.is_in_group("enemy") or body.is_in_group("spikes"):
		$DeathSound.play()
		velocity = Vector2.ZERO
		position = Vector2(999,999)
		Global.lives -= 1
		died = true
		$CollisionShape2D.disabled = true
		
		if Global.lives > 0:
			$RespawnTimer.start()
			
			hide()
			hit.emit()
		else:
			SceneTransitions.change_scene_to_file("res://GameOver.tscn")


func _on_power_up_timer_timeout():
	MAX_SPEED = MAX_SPEED / 1.15
	JUMP_VELOCITY = JUMP_VELOCITY / 1.15 # Replace with function body.
	print("power up end")
	
func _on_power_up_activate():
	MAX_SPEED = MAX_SPEED * 1.15
	JUMP_VELOCITY = JUMP_VELOCITY * 1.15
	$PowerUpTimer.start()
	print("power up activated")
	$PowerUpSound.play()
	
