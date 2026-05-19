class_name LevelTileMapLayer extends TileMapLayer

@export var tile_size: float=  16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.ChangeTileMapBounds(GetTileMapBounds())
	pass 

func GetTileMapBounds() -> Array[Vector2]:
	var bounds: Array[Vector2] = []
	bounds.append(Vector2(get_used_rect().position * tile_size)+ global_position) ## for top left corner
	bounds.append(Vector2(get_used_rect().end * tile_size)+ global_position) ## for bottom right corner
	return bounds
