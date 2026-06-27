extends CharacterBody2D


const SPEED = 150.0
var SPEED_MOD = 1.0

var can_move : bool = false
var soul_color : Color = Color.RED

func _process(_delta: float) -> void:
	if Stats.player_invincibilty > 0 and !$sprite.is_playing():
		$sprite.frame = 1
		$sprite.play()
	if Stats.player_invincibilty <= 0:
		$sprite.stop()
		$sprite.frame = 0

func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("Left","Right")
	var y_input = Input.get_axis("Up", "Down")
	
	SPEED_MOD = (float(!Input.is_action_pressed("Exit")) + 1) / 2

	$sprite.modulate = soul_color
	
	if can_move:
		if soul_color == Color.RED:
			velocity = Vector2(x_input, y_input) * SPEED * SPEED_MOD * 60 * delta
		move_and_slide()
