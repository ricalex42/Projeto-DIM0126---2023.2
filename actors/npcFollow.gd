extends State
class_name NPCFollow

@export var npc: CharacterBody2D
@export var move_speed := 40.0

var player : CharacterBody2D

func Enter():
	get_node("../../AnimatedSprite2D").play("walking")
	player = get_tree().get_first_node_in_group(("Player"))

func PhysicsUpdate(delta:float):
	var direction = player.global_position - npc.global_position
	
	if direction.length() > 15:
		npc.velocity = direction.normalized() * move_speed
	else:
		npc.velocity = Vector2()
	
	if direction.length() > 100:
		Transitioned.emit(self, "NPCIdle")
	if direction.length() < 20:
		Transitioned.emit(self, "NPCAttack")
	if get_node("../..").health < 30:
		Transitioned.emit(self, "NPCSearchHeal")
		pass
