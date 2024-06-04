extends CharacterBody2D

class_name MobEnemy

const speed =30

var dir: Vector2
 
var is_bat_chase: bool

var player: CharacterBody2D 

var health =50
var health_max=50
var health_min=0
var dead=false
var taking_damage = false
var is_roaming: bool
var damage_to_deal = 1

func _ready():
	is_bat_chase=true

func _process(delta):
	State.mobDamage = damage_to_deal
	State.mobDamageZone = $MobDealDamageArea
	
	if !State.playerAlive:
		is_bat_chase=false
	
	move(delta)
	handle_animation()

func move(delta):
	player=State.playerBody
	if !dead:
		is_roaming=true
		if !taking_damage and is_bat_chase:
			velocity=position.direction_to(player.position)*speed
			dir.x=(abs(velocity.x)/velocity.x)
		elif taking_damage:
			var knockback_dir =position.direction_to(player.position) * -100
			velocity =knockback_dir
		else:
			velocity+=dir*speed*delta
	elif dead:
		velocity.x=0
		velocity.y=0
	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time=choose([1.0,1.5,2.0])
	if !is_bat_chase:
		dir = choose([Vector2.RIGHT,Vector2.UP,Vector2.DOWN,Vector2.LEFT])
		

func handle_animation():
	var animated_sprite= $AnimatedSprite2D
	if !dead and !taking_damage:
		animated_sprite.play("move")
		if dir.x ==-1:
			animated_sprite.flip_h =true
		elif dir.x ==1:
			animated_sprite.flip_h =false
	elif !dead and taking_damage:
		animated_sprite.play("hurt")
		await get_tree().create_timer(0.07).timeout
		taking_damage=false
	elif dead and is_roaming:
		is_roaming=false
		animated_sprite.play("death")
		await get_tree().create_timer(1).timeout
		self.queue_free()
		State.points +=1

func choose(array):
	array.shuffle()
	return array.front()


func _on_mob_hit_box_area_entered(area):
	if area ==State.playerDamageZone:
		var damage=State.damage
		take_damage(damage)

func take_damage(damage):
	health =max(0, health - State.damage)
	taking_damage=true
	if health ==0:
		dead=true


	
