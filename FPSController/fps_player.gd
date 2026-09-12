extends CharacterBody3D
class_name  Player

@export var SPEED = 3.0

@export_category("camera config")
@export var camera: Camera3D
@export var sensitivity = 0.2
var look_rot : Vector2
@export var min_angle = -80
@export var max_angle = 90

var enabled := true

func _ready():
	look_rot.y = rad_to_deg(global_rotation.y) # fix first rot being overwittern by look_rot

func _input(event):
	if !enabled: return
	
	if event is InputEventMouseMotion:
		look_rot.y -= (event.relative.x * sensitivity)
		look_rot.x -= (event.relative.y * sensitivity)
		look_rot.x = clamp(look_rot.x, min_angle, max_angle)
		
	if (Input.mouse_mode != Input.MOUSE_MODE_CAPTURED) and event is InputEventMouseButton: 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # https://www.reddit.com/r/godot/comments/1ead8h4/how_to_capture_mouse_properly_in_web_exports/
		
	_handle_mouse_mode_toggle()
	
func _handle_mouse_mode_toggle() -> void:
	if Input.is_action_just_pressed("ui_cancel"):  # this will probably get moved
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
func _update_look_rotation(delta: float) -> void:
	var plat_rot := get_platform_angular_velocity()
	look_rot.y += rad_to_deg(plat_rot.y * delta)
	camera.rotation_degrees.x = look_rot.x
	rotation_degrees.y = look_rot.y


func _process(delta: float) -> void:
	if !enabled: return
	
	_update_look_rotation(delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func disable_player() -> void:
	enabled = false
	camera.current = false
	
func enable_player() -> void:
	enabled = true
	camera.current = true
