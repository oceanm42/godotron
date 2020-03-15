extends RigidBody2D

export (float) var projectile_speed = 400

onready var main = get_node("/root/Scene")
onready var bound = main.get("bound")
onready var Enemy = load("res://Scenes/Enemy_1.gd")
onready var Score = get_node("/root/Scene/Score")

func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	main.play("shoot")
	
func _process(delta):
	if(position[0] < bound.left):
		#print("Destroy")
		queue_free()
	if(position[0] > bound.right):
		#print("Destroy")
		queue_free()
	if(position[1] < bound.up):
		#print("Destroy")
		queue_free()
	if(position[1] > bound.down):
		#print("Destroy")	
		queue_free()
		
	for body in get_colliding_bodies():
		#if(body.has_method("destroy_by_bullet")):
		if(body is Enemy):
			#main.play("scream")
			Score.score += 100
			main.play("hit")
			body.queue_free()
			queue_free()
	
	
