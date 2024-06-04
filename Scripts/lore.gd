extends Control

signal scene1_closed
signal scene2_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	$scene1.show()
	$scene1/Label.show()
	$scene1/Label2.hide()
	$scene1.play("Sparkly")
	
	display_scene1("In a world far far away...")
	await scene1_closed
	
	display_scene1("there lived all sorts of magical creatures")
	await scene1_closed
	
	display_scene1("This place was called Astrid")
	await scene1_closed
	
	$scene1.play("village")
	
	display_scene1("Deep inside the magical woods of Astrid was a secret village of nature faries")
	await scene1_closed
	
	display_scene1("The village was being plagued by a unknown disease for which there was no known cure")
	await scene1_closed
	
	display_scene1("The old mage of the village checked through all the village's manuscipts")
	await scene1_closed
	
	
	display_scene1("and he found an ancient prophecy")
	await scene1_closed
	
	$scene1.play("prophecy")
	
	$scene1/Label2.show()
	$scene1/Label.hide()
	
	display_scene2("temporary text")
	await scene2_closed
	
	display_scene2("When the village is upturned by a violent storm")
	await scene2_closed
	
	display_scene2("Deaths and suffering blazing the land")
	await scene2_closed
	
	display_scene2("The Hero of fate will journey through the dark forest of Esmeray")
	await scene2_closed
	
	display_scene2("By defeating the 3 guardians, the elixir he will find")
	await scene2_closed
	
	$scene1.play("hero")
	
	$scene1/Label.show()
	$scene1/Label2.hide()
	
	display_scene1("Suddenly the old mage was blinded by a bright light")
	await scene1_closed
	
	display_scene1("When the light receded a young boy was left behind")
	await scene1_closed
	
	display_scene1("And so began the journey of the hero")
	await scene1_closed
	
	display_scene1("he carries with him the last remaining hope of the village")
	await scene1_closed
	
	display_scene1("will he succeed")
	await scene1_closed
	
	display_scene1("or will the nature fairies fall into extinction...")
	await scene1_closed
	
	var scene = "res://UI/Start.tscn"
	get_tree().change_scene_to_file(scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_scene1(text):
	$AnimationPlayer.play("test_appear_1")
	$scene1/Label.text =text

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $scene1/Label.visible:
		emit_signal("scene1_closed")
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $scene1/Label2.visible:
		emit_signal("scene2_closed")

func display_scene2(text):
	$AnimationPlayer.play("text_appear_2")
	$scene1/Label2.text =text
