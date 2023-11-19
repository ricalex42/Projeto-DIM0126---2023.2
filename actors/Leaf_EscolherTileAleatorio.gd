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
#		var npc_goal_distance_estimate = manhattan_distance(npc_current_position, npc_target_position)
#		print("Start.g: ", npc_current_position)
#		print("Start.h: ", npc_goal_distance_estimate)
		
		var path = a_star(npc_current_position, npc_target_position)
		print(path)
		success()

func success():
	status = SUCCEEDED
	get_parent().child_success()

func get_current_tile():
	pass


func a_star(start_position: Vector2, goal_position: Vector2):
	# f(n) = g(n) + h(n)
	print(goal_position, start_position)
	var Start_dict = {
		g = 0,
		h = manhattan_distance(start_position, goal_position),
		coord = start_position,
		parent = null
	}
	var start_pos_g = 0
	var start_pos_h = manhattan_distance(start_position, goal_position)
	var open = [Start_dict]
	var closed = []
	
	var g_counter = 1
	
	while open.size() > 0:
		print("loop: ", g_counter)
		#var N = remove_lowest_f(open)
		var N = get_lowest_fn(open)
		print(N)
		
		if N.coord == goal_position:
			return path_to(N)
		
		closed.append(N)
		
		# up down left right
		#-----------------
		var tempUpTile = {g = null, h = null, coord = (N.coord + Vector2(0, -1)), parent = null}
		var tempDownTile = {g = null, h = null, coord = (N.coord + Vector2(0, 1)), parent = null}
		var tempLeftTile = {g = null, h = null, coord = (N.coord + Vector2(-1, 0)), parent = null}
		var tempRightTile = {g = null, h = null, coord = (N.coord + Vector2(1, 0)), parent = null}
		#-----------------
		#var neighbours = [N + Vector2(0, -1),N + Vector2(0, 1),N + Vector2(-1, 0),N + Vector2(1, 0)]
		var neighbours = [tempUpTile, tempDownTile, tempLeftTile, tempRightTile]
		#var neighbours2 = find_valid_neighbours(N)
		
		for child in neighbours:
			if child not in closed:
				#var child_g = g_counter
				#var child_h = manhattan_distance(child, goal_position)
				child.parent = N
				child.g = N.g + g_counter
				child.h = manhattan_distance(child.coord, goal_position)
				open.append(child)
		
		g_counter += 1
	
	return []


func path_to(node):
	var path = []
	var current = node
	while current != null:
		path.insert(0, current)
		current = current.parent
	
	return path
	pass


func find_valid_neighbours(N):
	var tile_coord = N.coord
	pass

func manhattan_distance(start_pos: Vector2, end_pos: Vector2) -> int:
	var dx = abs(end_pos.x - start_pos.x)
	var dy = abs(end_pos.y - start_pos.y)
	return dx + dy


func scene_to_tile_coordinate(scene_position: Vector2, tile_size: Vector2) -> Vector2:
	var tile_x = int(scene_position.x / tile_size.x)
	var tile_y = int(scene_position.y / tile_size.y)
	return Vector2(tile_x, tile_y)


func get_lowest_fn(open_list : Array):
	var lowest_f = 1000
	var lowest_node = null
	print("list before erase: ", open_list)
	for tile in open_list:
		var f = tile.g + tile.h
		if f < lowest_f:
			lowest_f = f
			lowest_node = tile
			pass
	pass
	open_list.erase(open_list.find(lowest_node))
	print("list after erase: ", open_list)
	return lowest_node
