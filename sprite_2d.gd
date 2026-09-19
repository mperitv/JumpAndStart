extends AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0

var velocity = Vector2.ZERO
var is_grounded = true

func _physics_process(delta: float) -> void:
	if position.y < 300:
		velocity.y += GRAVITY * delta
		is_grounded = false
	else:
		velocity.y = 0
		position.y = 300
		is_grounded = true

	if Input.is_action_just_pressed("jump") and is_grounded:
		velocity.y = JUMP_VELOCITY

	var input_x := Input.get_axis("left", "right")
	velocity.x = input_x * SPEED

	position += velocity * delta

	if input_x < 0:
		flip_h = false
	elif input_x > 0:
		flip_h = true

	if not is_grounded:
		_set_animation("jump")
	elif input_x != 0:
		_set_animation("walk")
	else:
		_set_animation("idle")

func _set_animation(anim_name: String) -> void:
	if animation != anim_name:
		play(anim_name)
