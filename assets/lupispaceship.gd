extends Area2D

const INITIAL_VALUE_ABOVE_GROUND = 48

const ROTATION_SPEED = 1.4
const ACCELERATION = 500
const DECELERATION = 200
const MAX_ROTATION = 0.8
const MAX_THRUST = 250
const FRICTION = 0.80

signal shoot

var carrot = preload("res://assets/carrot.tscn")

var shoot_delay := 0.0
var can_shoot := true

var screen_size : Vector2

var above_ground_position : float

var rot : float
var pos : Vector2

func _ready():
	update_screen_size()
	put_player_on_initial_position()

func _input(event):
	if event.is_action("ui_select") and can_shoot:
		emit_signal("shoot", carrot, position)
		can_shoot = false

func _process(delta):
	if not can_shoot:
		shoot_delay += delta
	
	if shoot_delay > 0.25:
		shoot_delay = 0
		can_shoot = true

func _physics_process(delta):
	update_screen_size()
	process_acceleration_input(delta)
	clamp_acceleration()
	accelerate()

func update_screen_size():
	screen_size = get_viewport_rect().size
	above_ground_position = screen_size.y - INITIAL_VALUE_ABOVE_GROUND

func put_player_on_initial_position():
	position.x = screen_size.x / 2
	position.y = above_ground_position
	pos = position
	rot = rotation
	
func process_acceleration_input(delta : float):
	if Input.is_action_pressed("ui_right"):
		pos.x += ACCELERATION * delta
	elif Input.is_action_pressed("ui_left"):
		pos.x -= ACCELERATION * delta
	
	if Input.is_action_pressed("ui_up"):
		pos.y -= ACCELERATION * delta
	elif not is_equal_approx(position.y, above_ground_position):
		pos.y += DECELERATION * delta

func clamp_acceleration():
	pos.y = clamp(pos.y, screen_size.y - MAX_THRUST, above_ground_position)
	pos.x = clamp(pos.x, 0, screen_size.x)

func accelerate():
	position = pos
