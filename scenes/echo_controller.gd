extends Node

@export var echo_duration := 3.0
var active := false

func _process(_delta):
	if Input.is_action_just_pressed("echo") and not active:
		activate_echo()

func activate_echo():
	active = true
	set_echo_platforms(true)

	await get_tree().create_timer(echo_duration).timeout

	set_echo_platforms(false)
	active = false

func set_echo_platforms(show: bool):
	for p in get_tree().get_nodes_in_group("echo_hidden"):
		p.get_node("ColorRect").visible = show
		p.get_node("CollisionShape2D").disabled = not show
