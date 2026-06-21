class_name Bed extends Interactable

signal sleep_requested

func interact() -> void:
	sleep_requested.emit()
