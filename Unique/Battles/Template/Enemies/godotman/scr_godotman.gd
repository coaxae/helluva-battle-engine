extends enemy

var animation_mode = 0



func animation_handler():
	character.scale = Vector2(1,1) + Vector2(
		sin(animation_timer/25.0)*0.04,
		cos(animation_timer/25.0)*0.04
	)
