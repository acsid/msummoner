extends Node


var player = preload("res://boat.tscn")

var score = 0
var endfish = 0
var endmoney = 0
var endlevel = 0
var endmanabottle = 0
var endtime = 0
var endmessage = ""
var bonus = 1.0

var timer = 0



var worldLevel = 1
var bottleneed = 50
var bottleratio = 2.5
var basebottle = 50
func newGame():
	bottleneed = 100
	worldLevel = 1
	get_tree().change_scene_to_packed(load("res://world.tscn"))

func mainMenu():
	get_tree().change_scene_to_packed(load("res://main_menu.tscn"))

func upLevel():
	bottleneed +=  worldLevel * basebottle * bottleratio
	print("new level")
	get_tree().change_scene_to_packed(load("res://world.tscn"))
	worldLevel += 1 

func _process(delta):
	if Input.is_action_just_pressed("info"):
		upLevel()

func spawn_player(pos = Vector2(0,0)):
	var playerInst = player.instantiate()
	playerInst .global_position = pos
	get_tree().get_current_scene().add_child.call_deferred(playerInst)

func endgame(fish,money,level,manabottle,bonus,message = "Game Over"):
	endfish = fish
	endmoney = money
	endlevel = level
	endmanabottle = manabottle
	
	score += fish * 10
	score += money * 50
	score *= level
	score += manabottle * 100
	score *= bonus
	score *= Game.worldLevel
	print(str(score))
	endmessage = message
	get_tree().change_scene_to_packed(load("res://ui/gameover.tscn"))
