extends Node2D

@export var porta: Porta
@export var max_coins: int
@onready var atual = $Camera2D/atual
@onready var max = $Camera2D/max

var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	max.text = "/"+str(max_coins)
	atual.text = str(coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_coin_up():
	coins += 1
	$CoinUp.play()
	porta.atualizaHUD(coins)
	atual.text = str(coins)
