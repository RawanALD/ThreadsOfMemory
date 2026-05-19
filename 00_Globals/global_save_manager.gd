extends Node


const SAVE_PATH = "user://" ## godot manages where to save files automatically even throughout different systems 

signal game_loaded
signal game_saved

var current_save: Dictionary = {
	scene_path = "",
	 player = {
		pos_x = 0, 
		pos_y = 0
		},
	items = [], 
	persistence = [], ##used for cases like if a player opens a chest it must remain open
	quests = [],
}

func save_game() -> void:
	update_player_data()
	update_scene_path()
	var file := FileAccess.open(SAVE_PATH + "save.sav",FileAccess.WRITE )
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav",FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line()) ##our json file is 1 line because we have 1 player & we are constantly updating that one line we can simply parse the first line
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	LevelManager.load_new_level(current_save.scene_path,"", Vector2.ZERO)
	
	await LevelManager.level_load_started
	
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x,current_save.player.pos_y))
	
	await LevelManager.level_loaded
	game_loaded.emit()
	pass 


func update_player_data() -> void: ##updating data in this function
	var p: MCPlayer = PlayerManager.player
	current_save.player.pos_y = p.global_position.y
	current_save.player.pos_x = p.global_position.x


func update_scene_path() -> void:
	var p: String = "" ## create a string to the path
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p
	pass
