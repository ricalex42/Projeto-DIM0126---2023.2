extends CharacterBody2D

var health = 100

func _physics_process(delta):
	move_and_slide()
	
	$HealthBar.value = health
	if health <= 0:
		self.queue_free()
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func hurt(damage):
	health -= damage
