extends KinematicBody2D

onready var player = get_parent().get_node("/root/Scene/Player")

var velocity = Vector2(0, 0)
var speed = 1000
	
func _process(delta):
	var angle = get_angle_to(player.position)
	
	velocity.x = cos(angle)
	velocity.y = sin(angle)
	
	move_and_slide(velocity * speed * delta)
