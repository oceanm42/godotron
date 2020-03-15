extends Area2D

func _ready():
	$".".connect("body_entered", self, "bodyEntered")

func bodyEntered(body):
	if(body.is_in_group("Player")):
		print("Have hit")
		body.queue_free()
		get_tree().paused = true
