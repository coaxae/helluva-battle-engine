extends weapon

var bar_tween_pos : Tween = null
@onready var knife_slash = $KnifeSlash



var sound_file = preload("res://Assets/Sounds/snd_laz_c2.wav")

func bars_go():
	var bar = bars[0]
	
	var side = randi_range(0,1) * 2 - 1
	
	bar.position.x = 280 * side
	bar.scale.y = 0
	var bar_tween_scale = get_tree().create_tween()
	bar_tween_scale.tween_property(bar, "scale:y", 1, 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	bar_tween_scale.play()

	bar_tween_pos = get_tree().create_tween()
	bar_tween_pos.tween_property(bar, "position:x", 280 * -side, 1.5)
	bar_tween_pos.play()
	
	await bar_tween_pos.finished
	
	done.emit()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter") and bar_tween_pos.is_running():
		bar_tween_pos.stop()
		bars[0].play()

		knife_slash.global_position = (enemy_to_hit.attack_point.global_position)
		knife_slash.show()
		
		knife_slash.rotation_degrees = randi_range(0, 359)
		
		knife_slash.play()
		
		final_damage = (350 - abs(  bars[0].position.x)) / 350.0 * damage
		final_damage = clamp(final_damage,damage*0.4, damage)
		
		Audio.play_sound(sound_file)
		enemy_to_hit.damage(int(final_damage))
		await knife_slash.animation_finished
		knife_slash.hide()
		
		#await get_tree().create_timer(0.6).timeout
		
		
		
		await get_tree().create_timer(2).timeout
		
		is_finished = true
		done.emit()
