extends CharacterBody2D

const SPEED := 300.0
const JUMP_VELOCITY := -400.0
const GRAVITY := 1200.0

@onready var sprite: AnimatedSprite2D = $Sprite


func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	# Flip sprite
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	# Animation logic (priority order)
	if not is_on_floor():
		play_animation("jump")
	elif direction != 0:
		play_animation("walk")
	else:
		play_animation("idle")

	move_and_slide()


func play_animation(name: String) -> void:
	if sprite.animation != name:
		sprite.play(name)
