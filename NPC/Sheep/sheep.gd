extends CharacterBody2D

const SPEED = 20.0

@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var timer = $MoveTimer

var direction = 1

func _ready() -> void:
	anim.play("idle")
	timer.timeout.connect(_pick_new_direction)
	timer.wait_time = randf_range(1.5, 4.0)
	timer.start()

func _physics_process(_delta: float) -> void:
	velocity.x = SPEED * direction
	move_and_slide()
	sprite.flip_h = direction == -1
	
	# If sheep hits a wall, flip direction immediately
	if is_on_wall() and direction != 0:
		direction *= -1

func _pick_new_direction() -> void:
	var choice = randi() % 3
	if choice == 2:
		direction = 0
		velocity.x = 0
		anim.play("idle")
	else:
		direction = [-1, 1][choice]
		anim.play("walk")
	
	timer.wait_time = randf_range(1.5, 4.0)
	timer.start()
