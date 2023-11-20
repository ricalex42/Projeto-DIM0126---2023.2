extends Task

class_name Leaf_EncontrarJogador

@export var npc: CharacterBody2D
var player : CharacterBody2D

func start():
	status = ENTER
	for child in get_children():
		child.tree = self.tree
		child.start()
	player = get_tree().get_first_node_in_group(("Player"))

func run():
	status = RUNNING
	if status == RUNNING:
		var npc_current_position = scene_to_tile_coordinate(npc.global_position, Vector2(16,16))
		var npc_target_position = scene_to_tile_coordinate(player.global_position, Vector2(16,16))
		var path = a_star(npc_current_position, npc_target_position)
		$"../..".move_path = path
#		for i in path:
#			print(i)
		success()
	pass

func success():
	status = SUCCEEDED
	get_parent().child_success()


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
#		print("loop: ", g_counter)
#		for x in open:
#			print(x)
		var N = get_lowest_fn(open)

		if N.coord == goal_position:
			return path_to(N)

		closed.push_front(N)
		
		var neighbours2 = find_valid_neighbours(N)

		for child in neighbours2:
			var check = -1
			for i in closed:
				if i.coord == child.coord:
					check = 1
				pass
			if check == -1:
				child.parent = N
				child.g = N.g + 1
				child.h = manhattan_distance(child.coord, goal_position)
				open.push_front(child)
		
		g_counter += 1
	
	return []


func path_to(node):
	var path = []
	var current = node
	while current != null:
		path.insert(0, current.coord)
		current = current.parent
	return path
	pass


func find_valid_neighbours(N):
	var tile_coord = N.coord
	var tempUpTile = {g = null, h = null, coord = (N.coord + Vector2(0, -1)), parent = null}
	var tempDownTile = {g = null, h = null, coord = (N.coord + Vector2(0, 1)), parent = null}
	var tempLeftTile = {g = null, h = null, coord = (N.coord + Vector2(-1, 0)), parent = null}
	var tempRightTile = {g = null, h = null, coord = (N.coord + Vector2(1, 0)), parent = null}
	# check up tile
	var temp_neighbours = [tempUpTile, tempDownTile, tempLeftTile, tempRightTile]
	var valid_neighbours = []
	
	var w_tilemap = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("TileMap")
	for neigh in temp_neighbours:
		if(w_tilemap.get_cell_source_id(0, neigh.coord) != -1):
			#print(neigh.coord, "is valid")
			valid_neighbours.append(neigh)
	
	return valid_neighbours


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
	var current_g = open_list[0].g
	var lowest_node = null
	var index_of_lowest
	for tile in open_list:
		var f = tile.g + tile.h
		if f < lowest_f:
			lowest_f = f
			lowest_node = tile
			pass
		elif f == lowest_f:
			if tile.g > current_g:
				lowest_f = f
				lowest_node = tile
			elif tile.g == current_g:
				if current_g % 2 == 0:
					lowest_f = f
					lowest_node = tile
				pass
				
	pass
	open_list.remove_at(open_list.find(lowest_node))
	return lowest_node
