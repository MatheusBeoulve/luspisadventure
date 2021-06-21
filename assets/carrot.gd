extends Area2D

var velocity = Vector2(0, -300)

func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
