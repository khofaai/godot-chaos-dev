extends Node


var music_audio_player_count : int = 2
var current_music_player : int = 0
var music_players : Array[AudioStreamPlayer] = []
var music_bus : String = 'Music'

var music_fade_duration : float = 0.5


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in music_audio_player_count:
		var _audio_player = AudioStreamPlayer.new()
		add_child(_audio_player)
		_audio_player.bus = music_bus
		music_players.append(_audio_player)
		_audio_player.volume_db = -40
	pass


func play_music(_audio: AudioStream) -> void:
	if _audio == music_players[current_music_player].stream:
		return
	
	# this condition to play music even if the scene doesn't have a music attached to it
	#elif _audio == null:
		#return
	
	current_music_player += 1
	if current_music_player > 1:
		current_music_player = 0
	
	var current_audio_player : AudioStreamPlayer = music_players[current_music_player]
	current_audio_player.stream = _audio
	play_and_fadein(current_audio_player)
	
	var old_audio_player = music_players[1]
	
	if current_music_player == 1:
		old_audio_player = music_players[0]
	fadeout_and_stop(old_audio_player)
	
	pass


func play_and_fadein(_audio_player: AudioStreamPlayer) -> void:
	_audio_player.play(0)
	var tween : Tween = create_tween()
	tween.tween_property(_audio_player, 'volume_db', 0, music_fade_duration)
	pass



func fadeout_and_stop(_audio_player: AudioStreamPlayer) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(_audio_player, 'volume_db', -40, music_fade_duration)
	await tween.finished
	_audio_player.stop()
	pass


