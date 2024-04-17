extends Node2D


@onready var ui = get_tree().get_current_scene().get_node("mainui")
var coin = preload("res://object/coin.tscn")
var mana = preload("res://object/mana.tscn")
var lake = preload("res://lake.tscn")

var mana_needed = 100



# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn_player()
	ui.addinfo("Press: A D and arrows to got left and right")
	ui.addinfo("Spacebar = Action button")
	ui.addinfo("Q = Drink Mana")
	ui.addinfo("1,2 to summon fishing buddy")
	ui.addinfo("You need to bring "+ str(Game.bottleneed)  +" bottle of mana")
	ui.addinfo("on the other side of the lake")
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mute"):
		$AudioStreamPlayer.stop()
	pass


func spawn_coin(pos = Vector2(0,0)):
	var coinInst = coin.instantiate()
	coinInst.global_position = pos
	add_child(coinInst)
	
func spawn_mana(pos = Vector2(0,0)):
	var manaInst = mana.instantiate()
	manaInst.global_position = pos
	add_child(manaInst)
	



func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
