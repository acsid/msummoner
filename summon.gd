extends Node2D

@onready var player = get_tree().get_current_scene().get_node("boat")
@onready var world = get_tree().get_current_scene()
@onready var ui = get_tree().get_current_scene().get_node("mainui")

var fish = preload("res://fish.tscn")
var firefish = preload("res://object/firefish.tscn")
@export var expire = 10
@export var speed = 20
@export var firefisha = 0
@export var firefishrate = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$Despawn.start(expire)
	$Fish.start(speed)
	$AnimatedSprite2D.play("default")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fish_timeout():
	var spawnfish = fish
	print(firefishrate)
	var firerate = randi_range(0,firefishrate)
	print(firerate)
	if firefisha != 0:
		if  firerate == 1:
			spawnfish = firefish
		else:
			spawnfish = fish
	var fishInst = spawnfish.instantiate()
	fishInst.global_position = global_position
	get_tree().get_current_scene().add_child(fishInst)


func _on_despawn_timeout():
	queue_free()


func _on_nospawn_body_entered(body):
	if body.name == player.name:
		print("test")
		player.cansummon = false
		


func _on_nospawn_body_exited(body):
	if body.name == player.name:
		player.cansummon = true
