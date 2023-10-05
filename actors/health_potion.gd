extends Area2D

var potionPower = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Quando for tocado por um objeto, cura-o e se remove do jogo.
func _on_body_entered(body):
	body.health += potionPower
	self.queue_free()
	pass # Replace with function body.
