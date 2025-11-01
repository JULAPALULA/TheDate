extends PlayerState

func update(delta):
	player._delta += delta
	var cam_bob = floor(abs(1)+abs(1)) * player._delta * 1
	var objCam = player.origCamPos + Vector3.UP * sin(cam_bob) * .15
	
	player.camera_3d.position = player.camera_3d.position.lerp(objCam, delta)
	if player._delta > 10:
		player._delta = 0

func physics_update(delta: float) -> void:
	if player.process_input(delta) != Vector3.ZERO:
		state_machine.transition_to("Walk",{})
		return
	
	player.velocity = player.velocity.lerp(Vector3.ZERO, player.friction * delta)
	player.move_and_slide()
