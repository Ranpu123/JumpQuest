extends Node2D

@export var sound:AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	sound.play()
	Global.lives = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
