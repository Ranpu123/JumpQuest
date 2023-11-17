class_name Enemy2
extends CharacterBody2D


const DOWN_MAX_SPEED = 30.0
const UP_MAX_SPEED = -1.0
const UP_SPEED = -1.0
const DOWN_ACCELERATION = 10.0

@onready var startPosition = position

@onready var fsm = $FiniteStateMachine
@onready var flutuar = $FiniteStateMachine/FlutuarEnemy
@onready var cair = $FiniteStateMachine/CairEnemy
@onready var aterrissar = $FiniteStateMachine/AterrissarEnemy
@onready var subir = $FiniteStateMachine/SubirEnemy


func _ready():
	flutuar.player_under.connect(fsm.change_state.bind(cair))
	cair.hit_ground.connect(fsm.change_state.bind(aterrissar))
	aterrissar.landed.connect(fsm.change_state.bind(subir))
	subir.back_in_place.connect(fsm.change_state.bind(flutuar))
