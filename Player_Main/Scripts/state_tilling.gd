class_name State_Tilling extends State


var _finished := false


@onready var idle : State = $"../Idle"


func Enter() -> void:
	player.velocity = Vector2.ZERO
	_finished = false
	player.UpdateDirectionalAnimation("tilling")
	await player.animation_player.animation_finished
	_finished = true

func Exit() -> void:
	pass

func process(_delta: float) -> State:
	if _finished:
		return idle
	return null

func physics(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	return null

func HandleInput(_event: InputEvent) -> State:
	return null
