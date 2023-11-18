extends Task

class_name LeafEscolherLocalAleatorio

var count = 0
const MAX = 100

func run():
	status = RUNNING
	if status == RUNNING:
		print("INICIOU SEQUENCIA ESCOLHER LOCAL ALEATORIO")
		var rng = RandomNumberGenerator.new()
		var rndX = rng.randi_range(-20, 20)
		var rndY = rng.randi_range(-20, 20)
		$"../..".target = $"../../..".global_position + Vector2(rndX, rndY)
		success()

func success():
	status = SUCCEEDED
	get_parent().child_success()
