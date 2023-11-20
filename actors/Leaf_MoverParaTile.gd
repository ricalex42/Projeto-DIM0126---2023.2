extends Task

class_name Leaf_MoverParaTile

@export var npc: CharacterBody2D

var current_point = 0

func run():
	if status != RUNNING:
		print("INICIOU SEQUENCIA MOVER PARA TILE")
		status = RUNNING
	if status == RUNNING:
		var path = $"../..".move_path
		
		
#		if current_point < path.size():
#			var target_position = path[current_point]
#			var distance = 5 *  $"../.."._delta # Adjust speed by changing this value
#			# Move towards the target position
#			if npc.position.distance_to(target_position) > distance:
#				var direction = (target_position - npc.position).normalized()
#				npc.position += direction * distance
#			else:
#				npc.position = target_position
#				current_point += 1
		if current_point < path.size():
			var npc_coord = scene_to_tile_coordinate(npc.global_position, Vector2(16,16))
			var target_position = path[current_point]
			var direction = target_position - npc_coord
			npc.velocity = direction.normalized() * 40
			print("target postion: ", target_position)
			print("npc position: ", npc_coord)
			print("direction length ", direction.length())
			if direction.length() < 0.1:
				#npc.position = target_position
				current_point += 1
		if(current_point >= path.size()):
			success()
		else:
			running()
			print("going to ", path[current_point])
			
		
	pass

func success():
	status = SUCCEEDED
	get_parent().child_success()


func scene_to_tile_coordinate(scene_position: Vector2, tile_size: Vector2) -> Vector2:
	var tile_x = int(scene_position.x / tile_size.x)
	var tile_y = int(scene_position.y / tile_size.y)
	return Vector2(tile_x, tile_y)
