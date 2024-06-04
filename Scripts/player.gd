extends CharacterBody2D

@export var speed=60

@onready var animation_sprite =$sprites
@onready var deal_damage_zone =$DealDamageZone
@onready var sfx_walk = $sfx_walk
@onready var sfx_attack = $sfx_attack

var is_attacking =false
var new_direction=Vector2(0,1)
var animation

var damage_zone_collision

var health=State.current_health
var health_max=State.max_health
var can_take_damage:bool
var dead:bool

func _ready():
	State.playerBody=self
	State.playerAlive=true
	damage_zone_collision=deal_damage_zone.get_node("CollisionShape2D")
	damage_zone_collision.disabled=true
	dead=false
	can_take_damage=true
	set_progress($HP,State.current_health, health_max) 

func _physics_process(delta):
	State.playerDamageZone = deal_damage_zone
	set_progress($HP,State.current_health , health_max) 
	
	var direction: Vector2
	direction.x=Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y=Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if abs(direction.x)==1 and abs(direction.y) ==1:
		direction = direction.normalized()
	
	if Input.is_action_pressed("ui_sprint"):
		speed=120
	elif Input.is_action_just_released("ui_sprint"):
		speed=60
	
	var movement =speed * direction * delta
	
	if (is_attacking ==false) and !dead:
		move_and_collide(movement)
		player_animations(direction)
	
	if !dead and !Input.is_anything_pressed():
		if is_attacking==false:
			animation="idle_"+returned_direction(new_direction)
	
	if !dead:
		check_hitbox()

func check_hitbox():
	var hitbox_areas = $PlayerHitBox.get_overlapping_areas()
	var damage: int
	if hitbox_areas:
		var hitbox=hitbox_areas.front()
		if hitbox.get_parent() is MobEnemy:
			damage=State.mobDamage
			
	if can_take_damage:
		take_damage(damage)

func take_damage(damage):
	if damage !=0:
		health=max(0,health-damage)
		State.current_health=health
		if health==0:
			dead=true
			State.playerAlive=false
			handle_death_animation()
		take_damage_cooldown(1.0)

func take_damage_cooldown(wait_time):
	can_take_damage=false
	await get_tree().create_timer(wait_time).timeout
	can_take_damage=true

func handle_death_animation():
	animation_sprite.play("death")
	await get_tree().create_timer(2).timeout
	self.queue_free()
	var scene = "res://UI/Fallen.tscn"
	get_tree().change_scene_to_file(scene)

func _input(event):
	if !dead and event.is_action_pressed("ui_attack"):
		is_attacking =true
		animation="attack_"+returned_direction(new_direction)
		animation_sprite.play(animation)
		sfx_attack.play()
		damage_zone_collision.disabled =false

func player_animations(direction: Vector2):
	if direction != Vector2.ZERO:
		new_direction=direction
		animation= "walk_"+returned_direction(new_direction)
		animation_sprite.play(animation)
		if !sfx_walk.playing:
			sfx_walk.play()
	else:
		animation= "idle_" +returned_direction(new_direction)
		animation_sprite.play(animation)

func returned_direction(direction: Vector2):
	var normalized_direction= direction.normalized()
	var default_return= "side"
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y <0:
		return "up"
	elif normalized_direction.x >0:
		$sprites.flip_h = false
		deal_damage_zone.scale.x=1
		return "side"
	elif normalized_direction.x <0:
		$sprites.flip_h = true
		deal_damage_zone.scale.x=-1
		return "side"
	
	return default_return


func _on_animated_sprite_2d_animation_finished():
	is_attacking=false
	damage_zone_collision.disabled=true

func set_progress(progress_bar, health, max_health):
	progress_bar.value=health
	progress_bar.max_value=max_health
