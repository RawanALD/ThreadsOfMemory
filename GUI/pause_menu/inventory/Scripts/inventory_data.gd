class_name InventoryData extends Resource
##SALMA'S CODE FOR CHESTS
@export var slots: Array[SlotData]

func add_item(item: ItemData, amount: int = 1) -> bool:
	for slot in slots:
		if slot.item_data == item:
			slot.quantity += amount
			return true
	for slot in slots:
		if slot.item_data == null:
			slot.item_data = item
			slot.quantity = amount
			return true
	return false

func remove_item(item: ItemData, amount: int = 1) -> void:
	for slot in slots:
		if slot.item_data == item:
			slot.quantity -= amount
			if slot.quantity <= 0:
				slot.item_data = null
				slot.quantity = 0
			return
