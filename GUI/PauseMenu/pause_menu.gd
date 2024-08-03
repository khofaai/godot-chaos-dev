extends CanvasLayer


signal shown
signal hidden

@onready var audio_stream_player: AudioStreamPlayer = $Control/AudioStreamPlayer
@onready var button_save: Button = $Control/VBoxContainer/Button_Save
@onready var button_load: Button = $Control/VBoxContainer/Button_Load
@onready var item_description: Label = $Control/ItemDescription


var is_paused : bool = false



func _ready():
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)
	pass



func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed('pause'):
		if !is_paused:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()


func show_pause_menu() -> void:
	toggle_pause_menu(true)
	shown.emit()
	pass


func hide_pause_menu() -> void:
	toggle_pause_menu(false)
	hidden.emit()
	pass
	
func toggle_pause_menu(status : bool) -> void:
	get_tree().paused = status
	visible = status
	is_paused = status


func _on_save_pressed() -> void:
	if !is_paused:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass



func _on_load_pressed() -> void:
	if !is_paused:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_pause_menu()
	pass


func update_item_description(new_text : String) -> void:
	item_description.text = new_text
	pass


func play_audio(audio : AudioStream) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
	pass


