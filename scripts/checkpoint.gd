extends Node2D

@onready var flag: AnimatedSprite2D = $Flag
@onready var pole: Sprite2D = $Pole
@onready var spawnpoint: Spawnpoint = $Spawnpoint
@onready var particles: CPUParticles2D = $CPUParticles2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		var player: Player = area.get_parent()
		
		player.spawnpoint = spawnpoint
		if particles:
			particles.restart()

func _on_cpu_particles_2d_finished() -> void:
	particles.queue_free()
