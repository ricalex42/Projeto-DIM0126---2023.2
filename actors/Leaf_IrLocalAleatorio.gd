extends Task

class_name LeafIrLocalAleatorio

@export var npc: CharacterBody2D
var move_speed = 40

func run():
	if status != RUNNING:
		print("INICIOU SEQUENCIA IR LOCAL ALEATORIO")
		status = RUNNING
	if status == RUNNING:
		var direction = $"../..".target - npc.position
		npc.velocity = direction.normalized() * move_speed
		if direction.length() < 5:
			print("FINALIZOU SEQUENCIA IR LOCAL ALEATORIO")
			success()

func success():
	status = SUCCEEDED
	get_parent().child_success()
