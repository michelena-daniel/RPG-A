extends CharacterBody2D

@export var speed: float = 500.0
var target_position: Vector2 = Vector2.ZERO

func _physics_process(delta):
	if GameState.is_grid_open:
		return
	# Check if the left mouse button is being pressed
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		target_position = get_global_mouse_position()
		var direction = (target_position - position)
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	 # Attempt to move the character, capturing collision info
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider and collider is Companion:
			var isFull = GameState.find_first_empty_row(PlayerData.pets)
			if isFull != -1:
				GameState.add_companion(collider)
				collider.queue_free()
			else:
				print("Companions full")
