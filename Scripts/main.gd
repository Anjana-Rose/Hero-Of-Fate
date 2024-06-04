extends Node2D

var current_wave: int
@export var mob_scene: PackedScene

var starting_nodes: int
var current_nodes : int


func _ready():
	starting_nodes=get_child_count()
	current_nodes=get_child_count()

func mob_spawner():
	var mob_spawn1 =$mobSpawner1
	var mob_spawn2 =$mobSpawner2
	var mob_spawn3 =$mobSpawner3
	var mob_spawn4 =$mobSpawner4
	var mob_spawn5 =$mobSpawner5
	var mob_spawn6 =$mobSpawner6
	
	if current_nodes-starting_nodes <=1:
		var mob1=mob_scene.instantiate()
		mob1.global_position=mob_spawn1.global_position
		var mob2=mob_scene.instantiate()
		mob2.global_position=mob_spawn2.global_position
		var mob3=mob_scene.instantiate()
		mob3.global_position=mob_spawn3.global_position
		var mob4=mob_scene.instantiate()
		mob4.global_position=mob_spawn4.global_position
		var mob5=mob_scene.instantiate()
		mob5.global_position=mob_spawn5.global_position
		var mob6=mob_scene.instantiate()
		mob6.global_position=mob_spawn6.global_position
		add_child(mob1)
		add_child(mob2)
		add_child(mob3)
		add_child(mob4)
		add_child(mob5)
		add_child(mob6)
		await get_tree().create_timer(1).timeout
		

func _process(delta):
	current_nodes=get_child_count()
	mob_spawner()


























