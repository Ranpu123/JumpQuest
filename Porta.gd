class_name Porta
extends Area2D

@export var max_coin: int = 5
@onready var atual = $atual
@onready var max = $max
@export var next_scene: String

var cur_coins = 0

var inside: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	next_scene = "res://"+next_scene
	max.text = str(max_coin)
	atual.text = str(cur_coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(inside):
		if(Input.is_action_just_pressed("move_jump") and cur_coins >= max_coin):
			SceneTransitions.change_scene_to_file(next_scene)
			
	
func atualizaHUD(coins):
	cur_coins = coins
	atual.text = str(cur_coins)

func _on_body_entered(body):
	if(body.is_in_group("player")):
		inside = true

func _on_body_exited(body):
	if(body.is_in_group("player")):
		inside = false
