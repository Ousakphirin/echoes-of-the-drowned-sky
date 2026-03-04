extends Node

@export var echo_duration: float = 3.0
@export var echo_action: StringName = &"echo"

var active: bool = false

func _ready() -> void:
	# Ensure everything starts OFF (no invisible collisions)
	set_echo_platforms(false)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(echo_action) and not active:
		activate_echo()

func activate_echo() -> void:
	active = true
	set_echo_platforms(true)

	await get_tree().create_timer(echo_duration).timeout

	set_echo_platforms(false)
	active = false

func set_echo_platforms(show: bool) -> void:
	# Platforms must be in group: "echo_hidden"
	for p in get_tree().get_nodes_in_group("echo_hidden"):
		if p == null:
			continue

		# Show/hide the platform visuals
		if p.has_node("ColorRect"):
			p.get_node("ColorRect").visible = show
		elif p is CanvasItem:
			# Fallback: if the platform itself is drawable (Sprite2D, Node2D with visuals)
			(p as CanvasItem).visible = show

		# Enable/disable collision ONLY during echo
		if p.has_node("CollisionShape2D"):
			var col := p.get_node("CollisionShape2D") as CollisionShape2D
			col.disabled = not show
