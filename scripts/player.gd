class_name Player
extends CharacterBody2D

@export_group("Movement")
@export var speed: float = 150.0
@export var jump_velocity: float = -300.0
@export_group("")
@export var spawnpoint: Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

func _ready() -> void:
	if spawnpoint == null:
		printerr("Player does not have a spawnpoint assigned to it!")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if direction < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.play("idle")
	
	# play jumping animation if we are not on the floor
	if not is_on_floor():
		sprite.play("jump")

	move_and_slide()

func destroy():
	position = spawnpoint.position
	velocity = Vector2(0, 0)
