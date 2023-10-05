extends CharacterBody2D

# Character speed (adjust as needed)
var speed = 100
var energy = 0

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walking")
	else:
		$AnimatedSprite2D.play("idle")
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()

func _input(event):
	if event.is_action_pressed("attack"):
		var EnemyInRange = $AttackArea.get_overlapping_bodies()
		for x in EnemyInRange:
			x.hurt(25)
			print(x)
			pass
