extends Area2D

@export var win_screen_path: NodePath
@export var player_path: NodePath

@onready var win_screen := get_node(win_screen_path)
@onready var player := get_node(player_path)

var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if triggered:
		return
	if body != player:
		return
	triggered = true
	win_screen.show_win()
