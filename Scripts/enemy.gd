extends Area2D

var is_attacking=false

@export var enemy: Resource = null

func _ready():
	$sprite.texture=enemy.texture
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().paused =true
		var scene = "res://Scenes/Fight_"+str(State.level) +".tscn"
		get_tree().change_scene_to_file(scene)
		get_tree().paused = false
