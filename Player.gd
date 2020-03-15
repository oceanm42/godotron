extends KinematicBody2D


var velocity = Vector2()
var timer
var can_shoot = true

onready var main = get_node("/root/Scene")
onready var bound = main.get("bound")

export (int) var speed = 200
export (float) var wait_shoot_time = 1
export (int) var offset = 5
var bullet = preload("res://Scenes/Bullet.tscn")

func _ready():
	print(self.get_path())
	timer = Timer.new()
	timer.set_wait_time(wait_shoot_time)
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	
	
func get_input():
	#print(position)
	velocity = Vector2()

	
	if Input.is_action_pressed('ui_d') and position[0] < bound.right and Input.is_action_pressed('ui_w') and position[1] > bound.up:
		velocity.y -= 1
		velocity.x += 1
		$AnimatedSprite.play("right")
	elif Input.is_action_pressed('ui_d') and position[0] < bound.right and Input.is_action_pressed('ui_s') and position[1] < bound.down:
		velocity.y += 1
		velocity.x += 1
		$AnimatedSprite.play("right")
	elif Input.is_action_pressed('ui_a') and position[0] > bound.left and Input.is_action_pressed('ui_w') and position[1] > bound.up:
		velocity.y -= 1
		velocity.x -= 1
		$AnimatedSprite.play("left")
	elif Input.is_action_pressed('ui_a') and position[0] > bound.left and Input.is_action_pressed('ui_s') and position[1] < bound.down:
		velocity.y += 1
		velocity.x -= 1
		$AnimatedSprite.play("left")
		
		
	elif Input.is_action_pressed('ui_d') and position[0] < bound.right:
		velocity.x += 1
		$AnimatedSprite.play("right")
	elif Input.is_action_pressed('ui_a') and position[0] > bound.left:
		velocity.x -= 1
		$AnimatedSprite.play("left")
	elif Input.is_action_pressed('ui_s') and position[1] < bound.down:
		velocity.y += 1
		$AnimatedSprite.play("down")
	elif Input.is_action_pressed('ui_w') and position[1] > bound.up:
		velocity.y -= 1
		$AnimatedSprite.play("up")
	else:
		$AnimatedSprite.play("idle")		
	velocity = velocity.normalized() * speed

	if can_shoot:
		if Input.is_action_pressed('ui_right') and Input.is_action_pressed('ui_up'):
			shoot(offset, -offset, -45)
		elif Input.is_action_pressed('ui_left') and Input.is_action_pressed('ui_up'):
			shoot(-offset, -offset, -135)
		elif Input.is_action_pressed('ui_right') and Input.is_action_pressed('ui_down'):
			shoot(offset, offset, 45)
		elif Input.is_action_pressed('ui_left') and Input.is_action_pressed('ui_down'):
			shoot(-offset, offset, 135)
		
		elif Input.is_action_pressed('ui_right'):
			shoot(offset, 0, 0)
			
		elif Input.is_action_pressed('ui_left'):
			shoot(-offset, 0, 180)
			
		elif Input.is_action_pressed('ui_down'):
			shoot(0, +offset, 90)
			
		elif Input.is_action_pressed('ui_up'):
			shoot(0, -offset, -90)
	
func shoot(x, y, deg):
	can_shoot = false
	timer.start()
	var bullet_instance = bullet.instance()
	bullet_instance.position = Vector2(position[0] + x, position[1] + y)
	bullet_instance.rotation_degrees = deg
	get_parent().add_child(bullet_instance)
	
func _on_timer_timeout():
	can_shoot = true
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
