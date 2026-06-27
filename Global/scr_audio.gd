extends Node

var Music_Player = AudioStreamPlayer.new()

func play_sound(soundfile : AudioStream, volume : float = 1.0):
	var player = AudioStreamPlayer.new()
	
	player.stream = soundfile
	player.volume_linear = volume
	
	add_child(player)
	player.play()
	
	await player.finished
	player.queue_free()
	
func play_music(soundfile : AudioStream, volume : float = 1.0):
	if Music_Player.playing:
		Music_Player.stop()
	Music_Player.stream = soundfile
	Music_Player.volume_linear = volume

	if !Music_Player.is_inside_tree():
		add_child(Music_Player)
	
	Music_Player.play()
