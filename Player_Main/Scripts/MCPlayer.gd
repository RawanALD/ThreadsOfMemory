class_name MCPlayer extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction: Vector2)


func _ready():
	state_machine.initialize(self)


func _process(delta):
	direction = Vector2(
		Input.get_axis("Left","Right"),
		Input.get_axis("Up", "Down")
	)

func _physics_process(delta: float) -> void:
	move_and_slide()


func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false 
	
	var direction_id: int = int(round(direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size())
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false 
	
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

## Change animation based on player state
func UpdateAnimation(state :String) -> void:
	animation_player.play(state + "_" + AnimDirection())

## Change animation direction based on player direction
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
