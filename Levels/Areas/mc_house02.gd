extends Level

@onready var bed_granddaughter: Bed = $Bed
@onready var confirm_popup = $UILayer/ConfirmPopup
@onready var chest: Chest = $Chest
@onready var chest_ui = $UILayer/ChestUI

func _ready() -> void:
	super._ready()
	bed_granddaughter.sleep_requested.connect(_on_bed_sleep_requested)
	confirm_popup.confirmed.connect(_on_sleep_confirmed)
	chest.chest_opened.connect(_on_chest_opened)

func _on_bed_sleep_requested() -> void:
	confirm_popup.open_popup("Go to sleep?")

func _on_sleep_confirmed() -> void:
	print("Player went to sleep!")

func _on_chest_opened(p_inventory: InventoryData, c_inventory: InventoryData) -> void:
	chest_ui.open_chest(p_inventory, c_inventory)
