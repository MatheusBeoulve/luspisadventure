extends Area2D

signal shoot

var cheese = preload("res://assets/cheese.tscn")

var mood = "confident"

var can_shoot = true

var shoot_delay : float

var right = true

func _ready():
	$AnimationPlayer.play("Linear")

func _process(delta):
	if can_shoot:
		if right:
			emit_signal("shoot", cheese, right_arm_shoot_position())
			right = false
		else:
			emit_signal("shoot", cheese, left_arm_shoot_position())
			right = true
		can_shoot = false
	elif shoot_delay > 0.8 and mood == "confident":
		enable_shoot()
	elif shoot_delay > 0.5 and mood == "underestimate":
		enable_shoot()
	elif shoot_delay > 0.3 and mood == "hungry":
		enable_shoot()
	else:
		shoot_delay += delta

func enable_shoot():
	can_shoot = true
	shoot_delay = 0

func right_arm_shoot_position():
	return position + $RightArm.position + get_parent().position

func left_arm_shoot_position():
	return position + $LeftArm.position + get_parent().position
