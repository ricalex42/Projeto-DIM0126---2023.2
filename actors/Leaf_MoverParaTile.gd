extends Task

class_name Leaf_MoverParaTile

@export var npc: CharacterBody2D

func run():
	if status != RUNNING:
		print("INICIOU SEQUENCIA MOVER PARA TILE")
		status = RUNNING
	if status == RUNNING:
		var direction = $"../..".target - npc.position
		
	pass

func success():
	status = SUCCEEDED
	get_parent().child_success()
