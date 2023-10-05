extends State
class_name NPCSearchHeal

@export var npc: CharacterBody2D
@export var move_speed := 30.0

var heal_item : Area2D
var HealItemInRange 
func Enter():
	get_node("../../AnimatedSprite2D").play("walking")
	heal_item = get_tree().get_first_node_in_group(("heal_item"))

func PhysicsUpdate(delta:float):
	if is_instance_valid(heal_item):
		var direction = heal_item.global_position - npc.global_position
		if direction.length() > 15:
			npc.velocity = direction.normalized() * move_speed
		else:
			npc.velocity = Vector2()
	else:
		Transitioned.emit(self, "NPCIdle")
		pass

	if $"../..".health > 30:
		Transitioned.emit(self, "NPCIdle")
		pass
