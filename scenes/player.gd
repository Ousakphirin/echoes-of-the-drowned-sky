extends CharacterBody2D

const SPEED := 300.0
const JUMP_VELOCITY := -400.0
const GRAVITY := 1200.0

func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# left/right
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	move_and_slide()
