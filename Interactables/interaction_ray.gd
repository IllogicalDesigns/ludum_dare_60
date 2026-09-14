extends RayCast3D
class_name InteractionRay

var interactable: Interactable
var last_interacted_interactable

func _process(_delta: float) -> void:
	var collider = get_collider()
	var new_interactable = collider as Interactable

	# Check if the target has changed
	if new_interactable != interactable:
		# 1. Tell the old object we stopped looking at it
		if interactable:
			interactable.on_hover_exit()
		
		# 2. Update the reference
		interactable = new_interactable
		
		# 3. Tell the new object we are looking at it
		if interactable:
			interactable.on_hover_enter()
			
	if interactable and Input.is_action_just_pressed("interact"):
		last_interacted_interactable = interactable.associated_hint
		interactable.interact_with()
