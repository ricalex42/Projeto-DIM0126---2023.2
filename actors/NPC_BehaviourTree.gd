extends Task

class_name NPC_BehaviourTree

# essa BT terá 3 estados: procurar, perseguir e morrer
var target = Vector2()

func _ready():
	tree = self
	start()
	status = RUNNING

func _process(_delta):
	if status == RUNNING:
		get_child(0).run()

func run():
	get_child(0).run()
	running()
