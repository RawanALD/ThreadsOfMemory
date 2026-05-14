class_name State_Walk extends State
@export var move_speed : float = 70.0
@onready var idle : State = $"../Idle"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.

## what happens when the player enters this state?
func Enter() -> void:
	player.UpdateAnimation("walking")
	pass


## what happens when the player exits this state?
func Exit() -> void:
	pass

func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walking")
	return null

func physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null
