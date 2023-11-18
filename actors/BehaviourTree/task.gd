extends Node

class_name Task

enum {
	ENTER,
	RUNNING,
	FAILED,
	SUCCEEDED,
	CANCELLED
}

var tree = null
var status = ENTER

func running():
	status = RUNNING
		
func success():
	status = SUCCEEDED

func fail():
	status = FAILED
		
func cancel():
	if status == RUNNING:
		status = CANCELLED
		for child in get_children():
			child.cancel()

func run():
	pass
func child_success():
	pass
func child_fail():
	pass
func child_running():
	pass

func start():
	status = ENTER
	for child in get_children():
		child.tree = self.tree
		child.start()

func reset():
	cancel()
	status = ENTER
