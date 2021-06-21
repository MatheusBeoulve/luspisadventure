extends Area2D

signal damage

var velocity = Vector2(0, 140)

func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("damage")
