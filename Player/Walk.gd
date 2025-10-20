extends PlayerState

func physics_update(delta: float) -> void:
	player.velocity = player.velocity.lerp(player.direction * player.speed, player.accel * delta)
	player.move_and_slide()
