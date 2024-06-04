extends Control


func _ready():
	$stats_ColorRect.hide()
	get_tree().paused=false
	$pause_ColorRect.hide()
	

func stats_resume():
	$stats_ColorRect.hide()
	get_tree().paused = false

func resume():
	$pause_ColorRect.hide()
	get_tree().paused = false

func _input(_event):
	if Input.is_action_just_pressed("menu"):
		var diff = State.max_health- State.current_health
		if diff==0:
			$stats_ColorRect/Health/Label/BuyPotion.text=("max")
		$stats_ColorRect/Health/Label/CurrentValue.text=("%d" %State.current_health)
		$stats_ColorRect/Attack/Label/CurrentValue.text=("%d" %State.damage)
		$stats_ColorRect/Stun/Label/CurrentValue.text=("%d" %State.stun_percentage)
		$stats_ColorRect/CritRate/Label/CurrentValue.text=("%d" %State.crit_rate)
		$stats_ColorRect/CritDamage/Label/CurrentValue.text=("%d" %State.crit_damage)
		$stats_ColorRect/Points/Label.text=("%d" %State.points)
		$stats_ColorRect.show()
		get_tree().paused =true
	if Input.is_action_just_pressed("esc"):
		$pause_ColorRect.show()
		get_tree().paused =true
		
func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	stats_resume()


func _on_buy_potion_pressed():
	if State.points>=2:
		var diff = State.max_health- State.current_health
		if diff>0:
			State.current_health=State.max_health
			State.points-=2
			$stats_ColorRect/Health/Label/CurrentValue.text=("%d" %State.current_health)
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
	


func _on_cd_inc_pressed():
	if State.points>=2:
		var diff = State.max_crit_damage- State.crit_damage
		if diff >5: 
			State.crit_damage+=5
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/CritDamage/Label/CurrentValue.text=("%d" %State.crit_damage)
		elif diff<=5 and diff>0:
			State.crit_damage=State.max_crit_damage
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/CritDamage/Label/CurrentValue.text=("%d" %State.crit_damage)
			$stats_ColorRect/CritDamage/Label/CDInc.text=("max")


func _on_cr_inc_pressed():
	if State.points>=2:
		var diff = State.max_crit_rate- State.crit_rate
		if diff >5: 
			State.crit_rate+=5
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/CritRate/Label/CurrentValue.text=("%d" %State.crit_rate)
		elif diff<=5 and diff>0:
			State.crit_rate=State.max_crit_rate
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/CritRate/Label/CurrentValue.text=("%d" %State.crit_rate)
			$stats_ColorRect/CritRate/Label/CRInc.text=("max")


func _on_stun_inc_pressed():
	if State.points>=2:
		var diff = State.max_stun_percentage- State.stun_percentage
		if diff >5: 
			State.stun_percentage+=5
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/Stun/Label/CurrentValue.text=("%d" %State.stun_percentage)
		elif diff<=5 and diff>0:
			State.stun_percentage=State.max_stun_percentage
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/Stun/Label/CurrentValue.text=("%d" %State.stun_percentage)
			$stats_ColorRect/Stun/Label/StunInc.text=("max")


func _on_atk_inc_pressed():
	if State.points>=2:
		var diff = State.max_damage- State.damage
		if diff >5: 
			State.damage+=5
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/Attack/Label/CurrentValue.text=("%d" %State.damage)
		elif diff<=5 and diff>0:
			State.damage=State.max_damage
			State.points-=2
			$stats_ColorRect/Points/Label.text=("%d" %State.points)
			$stats_ColorRect/Attack/Label/CurrentValue.text=("%d" %State.damage)
			$stats_ColorRect/Attack/Label/AtkInc.text=("max")
		
