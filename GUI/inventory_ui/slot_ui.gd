extends Control
##SALMA'S CODE FOR CHEST
signal slot_clicked(slot_ui: Control)

@onready var item_label: Label = $Panel/ItemLabel
@onready var panel: Panel = $Panel

var slot_data: SlotData
var is_selected: bool = false

func _ready() -> void:
	panel.gui_input.connect(_on_panel_gui_input)

func set_slot(data: SlotData) -> void:
	slot_data = data
	refresh()

func refresh() -> void:
	if slot_data == null or slot_data.item_data == null:
		item_label.text = "Empty"
	else:
		item_label.text = "%s x%d" % [slot_data.item_data.name, slot_data.quantity]

func _on_panel_gui_input(event: InputEvent) -> void:
	print("Panel clicked!")
	if event is InputEventMouseButton and event.pressed:
		print("Mouse button pressed, emitting slot_clicked")
		slot_clicked.emit(self)

func set_selected(value: bool) -> void:
	is_selected = value
	panel.modulate = Color(1.5, 1.5, 1.0) if is_selected else Color(1, 1, 1)
