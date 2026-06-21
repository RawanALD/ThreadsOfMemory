class_name MCPlayer extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO
var current_interactable: Interactable = null

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var interaction_area : Area2D = $InteractionArea

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var inventory: Inventory

signal DirectionChanged(new_direction: Vector2)


func _ready():
	state_machine.initialize(self)
	interaction_area.area_entered.connect(_on_interaction_area_entered)
	interaction_area.area_exited.connect(_on_interaction_area_exited)


func _process(_delta):
	direction = Vector2(
		Input.get_axis("Left","Right"),
		Input.get_axis("Up", "Down")
	)

func _physics_process(_delta: float) -> void:
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and current_interactable:
		current_interactable.interact()
	
	##TEMP FOR DEBUGGING 
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_1:
				current_tool = DataTypes.Tools.None
			KEY_2:
				current_tool = DataTypes.Tools.WaterCrops
			KEY_3:
				current_tool = DataTypes.Tools.TillGround
			KEY_4:
				current_tool = DataTypes.Tools.PlantHenna
			KEY_5:
				current_tool = DataTypes.Tools.PlantBeetroot
			KEY_6:
				current_tool = DataTypes.Tools.PlantBluenila


func _on_interaction_area_entered(area: Area2D) -> void:
	if area is Interactable:
		current_interactable = area

func _on_interaction_area_exited(area: Area2D) -> void:
	if area == current_interactable:
		current_interactable = null


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

## change animation based on player state
func UpdateAnimation(state :String) -> void:
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	animation_player.play(state + "_" + AnimDirection())

## for animations with sides art (no left/right)
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

## for animations with left/right art (no sides)
func UpdateDirectionalAnimation(state: String) -> void:
	sprite.scale.x = 1  # these clips aren't mirrored, undo any previous flip
	var dir := "down"
	if cardinal_direction == Vector2.UP:
		dir = "up"
	elif cardinal_direction == Vector2.LEFT:
		dir = "left"
	elif cardinal_direction == Vector2.RIGHT:
		dir = "right"
	animation_player.play(state + "_" + dir)

##collect items if touched
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(inventory)
