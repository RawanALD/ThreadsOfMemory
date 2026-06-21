extends Control

signal confirmed
signal cancelled

@onready var yes_button: Button = $Panel/YesButton
@onready var no_button: Button = $Panel/NoButton
@onready var message_label: Label = $Panel/MessageLabel

func _ready() -> void:
	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)

func open_popup(message: String) -> void:
	message_label.text = message
	visible = true
	get_tree().paused = true

func close_popup() -> void:
	visible = false
	get_tree().paused = false

func _on_yes_pressed() -> void:
	close_popup()
	confirmed.emit()

func _on_no_pressed() -> void:
	close_popup()
	cancelled.emit()
