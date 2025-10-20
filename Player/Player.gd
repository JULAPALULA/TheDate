class_name Player
extends CharacterBody3D

@onready var camera_3d = $Camera3D
var canMoveAndRotate := true
var mouse_sens = 0.15
var contoller_sensitivity = 0.1

var joystick_deadzone = 0.2
var controller_sensitivity = 0.5
var friction := 2
var direction := Vector3()
var speed := 5
var accel = 5

func _ready() -> void:
	$MeshInstance3D.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if canMoveAndRotate:
		rotate_camera(event)

func _process(delta: float) -> void:
	process_camera_joystick()
	process_input(delta)

func process_input(delta) -> Vector3:
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	
	var frwd_input = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	var side_input = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	
	direction=Vector3(side_input,0,frwd_input).rotated(Vector3.UP, h_rot).normalized()
	print("Player direction:", direction)
	return direction

func rotate_camera(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera_3d.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func process_camera_joystick():
	if Input.get_joy_axis(0, 2) < -joystick_deadzone or Input.get_joy_axis(0,2) > joystick_deadzone:
		rotation.y -= Input.get_joy_axis(0,2) * contoller_sensitivity
	if Input.get_joy_axis(0, 3) < -joystick_deadzone or Input.get_joy_axis(0,3) > joystick_deadzone:
		camera_3d.rotation.x = clamp(camera_3d.rotation.x - Input.get_joy_axis(0,3) * contoller_sensitivity, -1.55,1.55)
