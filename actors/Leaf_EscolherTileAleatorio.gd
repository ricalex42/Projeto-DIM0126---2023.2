extends Task

class_name Leaf_EscolherTileAleatorio

@export var npc: CharacterBody2D

func run():
	status = RUNNING
	if status == RUNNING:
		print("INICIOU SEQUENCIA ESCOLHER LOCAL ALEATORIO COM A*")
		# para teste tentar alcançar o tile 0,0
		# 
		var npc_current_position = scene_to_tile_coordinate(npc.global_position, Vector2(16,16))
		var npc_target_position = Vector2(0,0)
		var npc_goal_distance_estimate = manhattan_distance(npc_current_position, npc_target_position)
		print("Start.g: ", npc_current_position)
		print("Start.h: ", npc_goal_distance_estimate)
		
		var path = a_star(npc_current_position)
		success()

func success():
	status = SUCCEEDED
	get_parent().child_success()

func get_current_tile():
	pass

func manhattan_distance(start_pos: Vector2, end_pos: Vector2) -> int:
	var dx = abs(end_pos.x - start_pos.x)
	var dy = abs(end_pos.y - start_pos.y)
	return dx + dy


func scene_to_tile_coordinate(scene_position: Vector2, tile_size: Vector2) -> Vector2:
	var tile_x = int(scene_position.x / tile_size.x)
	var tile_y = int(scene_position.y / tile_size.y)
	return Vector2(tile_x, tile_y)


func a_star(start_position: Vector2):
	var open = [start_position]
	var closed = []
	
	while open.size > 0:
		var N = remove_lowest_f(open)
		
		if goal(N):
			return path_to(N)
		
		closed.append(N)
		
		for child in get_children(N):
			if child not in closed:
				child.parent = N 
				child.g = N.g + real_cost(N, child)
				child.h = heuristic(child)
				open.append(child)
	
	return []


func remove_lowest_f(open_list: Array):
	var lowest_node = null
	var lowest_f = INFINITY
	
	for node in open_list:
		var f = node.g + node.h
		if f< lowest_f:
			lowest_f = f
			lowest_node = node
	
	open_list.erase(open_list.find(lowest_node))
	return lowest_node
