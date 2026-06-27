extends bullet


func _on_col_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		Stats.player_hurt(BULLET_DAMAGE)
