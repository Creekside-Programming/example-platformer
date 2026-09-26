extends CharacterBody2D

const SPEED := 50.0
const PLAYER_UPWARDS_VELOCITY_SET_ON_HIT: float = -350.0

var direction := 1.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var left_floor_ray: RayCast2D = $LeftFloorRay
@onready var right_floor_ray: RayCast2D = $RightFloorRay

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Walk
	velocity.x = direction * SPEED

	if not left_floor_ray.is_colliding() and is_on_floor():
		direction = 1.0 # avoid falling off the left cliff
		sprite.flip_h = true

	if not right_floor_ray.is_colliding() and is_on_floor():
		direction = -1.0 # avoid falling off the right cliff
		sprite.flip_h = false

	move_and_slide()


func _on_destroy_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		var player: Player = area.get_parent()
		if player.velocity.y > 0: # if they are actively falling
			player.velocity.y = PLAYER_UPWARDS_VELOCITY_SET_ON_HIT

			queue_free() # todo: animate death
