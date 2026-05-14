class_name State extends Node

static var player : MCPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

## what happens when the player enters this state?
func Enter() -> void:
	pass


## what happens when the player exits this state?
func Exit() -> void:
	pass

func process(_delta: float) -> State:
	return null


func physics(_delta: float) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null
