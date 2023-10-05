extends State
class_name NPCIdle

@export var npc: CharacterBody2D
@export var move_speed := 10.0
var player : CharacterBody2D

var move_direction : Vector2

func Enter():
	get_node("../../AnimatedSprite2D").play("idle")
	player = get_tree().get_first_node_in_group(("Player"))

func PhysicsUpdate(delta: float):
	if npc:
		npc.velocity = move_direction * move_speed
	
	var direction = player.global_position - npc.global_position
	
	if direction.length() < 100:
		Transitioned.emit(self, "NPCFollow")
