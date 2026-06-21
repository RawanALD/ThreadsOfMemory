class_name Chest extends Interactable

@export var chest_inventory: InventoryData

signal chest_opened(p_inventory: InventoryData, c_inventory: InventoryData)

func interact() -> void:
	chest_opened.emit(PlayerManager.player_inventory, chest_inventory)
