extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	size.x = 18 * Global.lives


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_hit():
	size.x = 18 * Global.lives
