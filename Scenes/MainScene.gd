extends Node2D

export (Dictionary) var bound = {'up': 35, 'down': 567, 'left': 33, 'right': 500}

var enemy = preload("res://Scenes/Enemy_1.tscn")
var player = preload("res://Scenes/Player.tscn")

func _ready():
	VisualServer.set_default_clear_color(0)
	create_wave(30)

func create_wave(enemy_count):
	randomize()
	var player_instance = player.instance()
	player_instance.position = Vector2(bound.right / 2, bound.down/2)
	add_child(player_instance)
	for i in range(enemy_count):
		var x = rand_range(bound.left, bound.right)
		var y = rand_range(bound.down, bound.up)
		var spawn = Vector2(x, y)
		var enemy_instance = enemy.instance()
		enemy_instance.position = spawn
		add_child(enemy_instance)

func play(sfx = null):
	if sfx:
		get_node(sfx).play()
