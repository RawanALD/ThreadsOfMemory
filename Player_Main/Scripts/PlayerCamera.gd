class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.tilemap_bounds_changed.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_bounds) ##force to update the first time we run the script
	pass # Replace with function body.

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func UpdateLimits( bounds: Array[ Vector2 ]) -> void:
	if bounds == []:
		return
	limit_left = int( bounds [0].x )
	limit_top = int( bounds [0].y )
	limit_right = int( bounds [1].x )
	limit_bottom = int( bounds [1].y )
	pass
