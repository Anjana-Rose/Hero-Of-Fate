extends Control

signal textbox_closed

@export var enemy: Resource = null

var current_player_health =0
var current_enemy_health =0
var is_stunned=false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_health($P1Data/VBoxContainer/ProgressBar,State.current_health , State.max_health) 
	set_health($Enemy/ProgressBar, enemy.health,enemy.health ) 
	$Enemy/sprite.texture=enemy.texture
	
	current_player_health=State.current_health
	current_enemy_health=enemy.health
	
	$Textbox.hide()
	$P1Data/VBoxContainer/Actions.hide()
	$ColorRect.hide()
	
	display_text("AHHH!!! It's a %s!!!" % enemy.name.to_upper())
	await textbox_closed
	$P1Data/VBoxContainer/Actions.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value=health
	progress_bar.max_value=max_health

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$P1Data/VBoxContainer/Actions.hide()
	$Textbox.show()
	$Textbox/Label.text =text

func enemy_turn():
	
	if is_stunned:
		is_stunned=false
		current_player_health =max(0, current_player_health + 20)
		set_health($P1Data/VBoxContainer/ProgressBar,current_player_health , State.max_health)
		display_text("The Player heals 20")
		await textbox_closed
	
	else:
		display_text("The %s attacks you fiercely" %enemy.name)
		await textbox_closed
		
		current_player_health =max(0, current_player_health - enemy.damage)
		set_health($P1Data/VBoxContainer/ProgressBar,current_player_health , State.max_health)
		
		$ColorRect.show()
		$AnimationPlayer.play("screenshake")
		await $AnimationPlayer.animation_finished
		$ColorRect.hide()
		
		display_text("The %s dealt %d damage" %[enemy.name, enemy.damage])
		await textbox_closed
		
		if current_player_health==0:
			var scene = "res://UI/Fallen.tscn"
			get_tree().change_scene_to_file(scene)
		
	await get_tree().create_timer(.25).timeout
	$P1Data/VBoxContainer/Actions.show()

func _on_attack_pressed():
	display_text("The Player chants a spell!")
	await textbox_closed
	var damage :int
	var i = (randi() % 101)
	if i<=State.crit_rate:
		damage= State.damage+ ((State.crit_damage/100)*State.damage)
		current_enemy_health =max(0, current_enemy_health - damage)
		set_health($Enemy/ProgressBar, current_enemy_health, enemy.health) 
		
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
		
		display_text("It's a Critical Hit!!")
		await textbox_closed
		
		display_text("the Player dealt %d damage." % damage)
		await textbox_closed
	else:
		current_enemy_health =max(0, current_enemy_health - State.damage)
		set_health($Enemy/ProgressBar, current_enemy_health, enemy.health) 
		
		$AnimationPlayer.play("enemy_damaged")
		await $AnimationPlayer.animation_finished
		
		display_text("P1 dealt %d damage." % State.damage)
		await textbox_closed
	
	if current_enemy_health ==0:
		display_text("The %s has been defeated" %enemy.name)
		await textbox_closed
		
		$AnimationPlayer.play("enemy_death")
		await $AnimationPlayer.animation_finished
		
		State.current_health=current_player_health
		
		await get_tree().create_timer(1).timeout
		State.level +=1
		if State.level>3:
			var scene = "res://UI/Victory.tscn"
			get_tree().change_scene_to_file(scene)
		else:
			var scene = "res://Scenes/Level_"+str(State.level) +".tscn"
			get_tree().change_scene_to_file(scene)
	
	enemy_turn()


func _on_defend_pressed():
	var i = (randi() % 101)
	if i<=State.stun_percentage:
		is_stunned=true
		display_text("The Enemy is stunned for 1 turn")
		await textbox_closed
	
	else:
		display_text("The Stun Failed")
		await textbox_closed
	await get_tree().create_timer(0.25).timeout
	enemy_turn()
