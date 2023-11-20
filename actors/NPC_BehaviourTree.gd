extends Task

class_name NPC_BehaviourTree

# essa BT terá 3 estados: procurar, perseguir e morrer
var target = Vector2()
var move_path = []
var player : CharacterBody2D
@export var npc: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group(("Player"))
	tree = self
	start()
	status = RUNNING

func _process(_delta):
	if status == RUNNING:
		var direction = player.global_position - npc.global_position
	
		if direction.length() < 50:
			get_child(1).run()
		else:
			get_child(0).run()
		

func run():
	get_child(0).run()
	running()
