extends State
class_name NPCAttack


func Enter():
	get_node("../../AnimatedSprite2D").play("attack")
	pass

func PhysicsUpdate(delta:float):	
	pass

func _on_animated_sprite_2d_animation_finished():
	Transitioned.emit(self, "NPCIdle")
	pass # Replace with function body.

func _on_animated_sprite_2d_animation_looped():
	Transitioned.emit(self, "NPCIdle")
	pass # Replace with function body.
