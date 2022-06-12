extends KinematicBody2D


var velocity=Vector2.ZERO
const ACCERLATION = 500
const MAX_SPEED = 100
const FRICTION = 500

onready var animation = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")


func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	if input != Vector2.ZERO:
		animationtree.set("parameters/Idle/blend_position", input)
		animationtree.set("parameters/Run/blend_position", input)
		velocity = velocity.move_toward(input * MAX_SPEED, ACCERLATION* delta)
		animationstate.travel("Run")
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
