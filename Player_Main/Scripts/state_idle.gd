class_name State_Idle extends State

@onready var walk : State = $"../walk"
@onready var water : State = $"../watering"
@onready var till : State = $"../tilling"
@onready var plant : State = $"../planting"


func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

func Exit() -> void:
	pass

func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null


func physics(_delta: float) -> State:
	return null


func HandleInput(event: InputEvent) -> State:
	if event.is_action_pressed("hit"):
		match player.current_tool:
			DataTypes.Tools.WaterCrops:
				return water
			DataTypes.Tools.TillGround:
				return till
			DataTypes.Tools.PlantHenna, DataTypes.Tools.PlantBeetroot, DataTypes.Tools.PlantBluenila:
				return plant
	return null
