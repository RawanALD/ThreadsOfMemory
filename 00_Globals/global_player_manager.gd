extends Node

const MC_PLAYER = preload("uid://bx14fpoasokum")
const PLAYER_INVENTORY = preload("res://GUI/pause_menu/inventory/player_inventory.tres")

var player: MCPlayer
var player_spawned : bool = false
var player_inventory: InventoryData

func _ready() -> void:
	player_inventory = PLAYER_INVENTORY

	if get_tree().current_scene.name == "ToolsPanel":
		return

	add_player_instance()

	await get_tree().create_timer(0.2).timeout
	player_spawned = true

func add_player_instance() -> void:
	player = MC_PLAYER.instantiate()
	add_child(player)

func set_player_position(_new_pos: Vector2) -> void:
	player.global_position = _new_pos
	pass

func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)
