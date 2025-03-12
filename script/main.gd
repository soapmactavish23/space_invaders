extends Node

const hiscore_file = "user://hiscore_file"
var pre_name_selector = preload("res://scenes/name_selector.tscn")
var pre_game = preload("res://scenes/game.tscn")
var game
var hiscore
var store_hiscore
var password = [52, 36, 78, 101, 75, 90, 120, 87, 61, 111, 37, 85]

var hiscores = [
	{name = "AAA", score = 1000},
	{name = "BBB", score = 900},
	{name = "CCC", score = 800},
	{name = "DDD", score = 700},
	{name = "EEE", score = 600},
	{name = "FFF", score = 500},
	{name = "GGG", score = 400},
	{name = "HHH", score = 300},
	{name = "III", score = 200},
	{name = "JJJ", score = 100},
]

var extra_life_index = 0
var score = 0
var lifes = 3

func _ready():
	get_node("hiscore").show_hiscores(hiscores)
	
func new_game():
	if game != null:
		game.queue_free()
	game = pre_game.instance()
	get_node("game_node").add_child(game)
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_victory")


func _on_Button_pressed():
	get_node("btn_new_game").hide()
	get_node("title").hide()
	get_node("hiscore").hide()
	get_node("wave_fx").hide()
	get_node("btn_options").hide()
	new_game()

func on_game_over():
	hiscore = null
	for hs in hiscores:
		if game.data.score > hs.score:
			hiscore = hs
			break;
	
	if hiscore != null:
		var name_selector = pre_name_selector.instance()
		add_child(name_selector)
		name_selector.connect("finished", self, "on_name_selector_finished")
		yield(name_selector, "finished")
		name_selector.queue_free()
		save_history()
	
	get_node("btn_new_game").show()
	get_node("title").hide()
	get_node("hiscore").show()
	get_node("wave_fx").show()
	get_node("btn_options").show()
	get_node("hiscore").show_hiscores(hiscores)

func on_victory():
	var data = game.data
	new_game()
	game.data = data

func on_name_selector_finished(val):
	var index = hiscores.find(hiscore)
	hiscores.insert(index, {name = val, score = game.data.score})
	hiscores.resize(10)

func save_history():
	var file = File.new()
	var result = file.open_encrypted_with_pass(hiscore_file, file.WRITE, RawArray(password).get_string_from_utf8())
	if result == OK:
		var score_hiscore = {
			hiscores = hiscores
		}
		file.store_string(store_hiscore.to_json())
		file.close()
		
func load_score():
	var file = File.new()
	var result = file.open_encrypted_with_pass(hiscore_file, file.READ, RawArray(password).get_string_from_utf8())
	if result == OK:
		var text = file.get_as_text()
		var store_hiscore = {}
		store_hiscore.parse_json(text)
		hiscores = store_hiscore.hiscores
		file.close()
	

func _on_btn_options_pressed():
	get_node("tween_camera").interpolate_property(get_node("camera"), "transform/pos", Vector2(0,0), Vector2(-180, 0), 1, Tween.TRANS_EXPO, Tween.EASE_OUT, 0)
	get_node("tween_camera").start()

func _on_volume_control_value_changed( value ):
	AudioServer.set_fx_global_volume_scale(value)
	get_node("options/sample").play("ship_shoot")


func _on_music_control_value_changed( value ):
	AudioServer.set_fx_global_volume_scale(value)
