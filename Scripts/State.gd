extends Node

var level=1

var current_health=100
var max_health=100
var damage=10
var max_damage =40
var stun_percentage=25
var max_stun_percentage=75
var crit_rate=10
var max_crit_rate=50
var crit_damage=100
var max_crit_damage=200
var is_attacking =false
var points=0

var playerBody: CharacterBody2D
var playerDamageZone: Area2D
var playerAlive : bool

var mobDamageZone: Area2D
var mobDamage: int
