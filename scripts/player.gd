class_name Player
extends CharacterBody2D

@export_group("Movement")
@export var speed: float = 150.0
@export var jump_velocity: float = -300.0
@export_group("")
@export var spawnpoint: Spawnpoint
@export var coins: int:
	get:
		return coins
	set(value):
		coins = value
		coins_changed.emit()

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

signal coins_changed

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
	
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)

		if collision.get_normal().y > 0.7:
			var collider = collision.get_collider()

			if collider.get_parent() is LuckyBlock:
				collider.get_parent().hit()

func destroy() -> void:
	position = spawnpoint.position
	velocity = Vector2(0, 0)
