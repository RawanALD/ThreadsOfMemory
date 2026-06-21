extends Control

const SLOT_UI = preload("res://GUI/inventory_ui/slot_ui.tscn")

@onready var player_list: VBoxContainer = $Panel/ListsContainer/PlayerScroll/PlayerList
@onready var chest_list: VBoxContainer = $Panel/ListsContainer/ChestScroll/ChestList
@onready var move_button: Button = $Panel/MoveButton

var player_inventory: InventoryData
var chest_inventory: InventoryData

var selected_slot_ui: Control = null
var selected_source: String = ""

func open_chest(p_inventory: InventoryData, c_inventory: InventoryData) -> void:
	player_inventory = p_inventory
	chest_inventory = c_inventory
	visible = true
	get_tree().paused = true
	refresh_lists()

func close_chest() -> void:
	visible = false
	get_tree().paused = false
	selected_slot_ui = null

func refresh_lists() -> void:
	for child in player_list.get_children():
		if child is Control and child.has_method("set_slot"):
			child.queue_free()
	for child in chest_list.get_children():
		if child is Control and child.has_method("set_slot"):
			child.queue_free()
	
	for slot in player_inventory.slots:
		var slot_ui = SLOT_UI.instantiate()
		player_list.add_child(slot_ui)
		slot_ui.set_slot(slot)
		slot_ui.slot_clicked.connect(_on_slot_clicked.bind(slot_ui, "player"))
	
	for slot in chest_inventory.slots:
		var slot_ui = SLOT_UI.instantiate()
		chest_list.add_child(slot_ui)
		slot_ui.set_slot(slot)
		slot_ui.slot_clicked.connect(_on_slot_clicked.bind(slot_ui, "chest"))

func _on_slot_clicked(slot_ui: Control, source: String) -> void:
	if selected_slot_ui:
		selected_slot_ui.set_selected(false)
	selected_slot_ui = slot_ui
	selected_source = source
	slot_ui.set_selected(true)

func _on_move_button_pressed() -> void:
	if selected_slot_ui == null or selected_slot_ui.slot_data == null:
		return
	if selected_slot_ui.slot_data.item_data == null:
		return
	
	var item = selected_slot_ui.slot_data.item_data
	var qty = selected_slot_ui.slot_data.quantity
	
	if selected_source == "player":
		player_inventory.remove_item(item, qty)
		chest_inventory.add_item(item, qty)
	else:
		chest_inventory.remove_item(item, qty)
		player_inventory.add_item(item, qty)
	
	selected_slot_ui = null
	refresh_lists()
