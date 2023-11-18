extends Task

class_name Leaf_PerserguirJogador

@export var npc: CharacterBody2D

func run():
	pass

func success():
	status = SUCCEEDED
	get_parent().child_success()
