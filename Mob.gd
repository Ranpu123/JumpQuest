class_name Enemy1
extends CharacterBody2D

const MAX_SPEED = 80.0
const SPEED = 50.0

var dir = 1

@onready var fsm = $FiniteStateMachine
@onready var andar = $FiniteStateMachine/AndarEnemy
@onready var virar = $FiniteStateMachine/VirarEnemy

func _ready():
	andar.next_border.connect(fsm.change_state.bind(virar))
	virar.turned.connect(fsm.change_state.bind(andar))
