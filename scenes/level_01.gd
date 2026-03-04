extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var spawn: Marker2D = $SpawnPoint

func _on_kill_zone_body_entered(body: Node) -> void:
	if body != player:
		return

	_respawn_player()

func _respawn_player() -> void:
	# Teleport back to spawn instantly
	player.global_position = spawn.global_position
	player.velocity = Vector2.ZERO

	# If you have animations, reset to idle (optional)
	if player.has_node("AnimatedSprite2D"):
		var spr = player.get_node("AnimatedSprite2D")
		if spr.has_method("play"):
			spr.play("idle")

	# If your camera is smoothing, force snap (optional)
	if player.has_node("Camera2D"):
		var cam: Camera2D = player.get_node("Camera2D")
		cam.reset_smoothing()
