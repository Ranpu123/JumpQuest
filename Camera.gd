extends Camera2D

const RANDOM_SHAKE_STRENGHT = 8.0
const SHAKE_DECAY_RATE = 20.0

var shake_strength = 0.0

@onready var rand = RandomNumberGenerator.new()

func _on_collision():
	shake_strength = RANDOM_SHAKE_STRENGHT
	
func _physics_process(delta):
	shake_strength = move_toward(shake_strength, 0, SHAKE_DECAY_RATE * delta)
	offset = _get_offset()
		
func _get_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength),
	)
