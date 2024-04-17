extends Control
var castTarget = randi_range(0,100)
var up = true;
var cast = 0
var casting = true
var castTime = 100
var castMulti = 1
@export var casttype = preload("res://summon.tscn")

var castwhat = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/castTarget.value = castTarget
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if casting:
		if up:
			cast += castMulti 
			if cast > 100:
				up = false
		else:
			cast -= castMulti 
			if cast < 1:
				up = true
		$VBoxContainer/castProgress.value = cast
	if Input.is_action_just_pressed("cast"):
		
		casting = false
		castTime -= abs(cast - castTarget)
		print( castTime )
		if castwhat == 2:
			print("firesummon")
			casttype = load("res://summon/firesummon.tscn")
		var summon = casttype.instantiate()
		summon.expire = castTime
		summon.global_position = get_parent().global_position
		summon.speed = abs(cast - castTarget)
		get_tree().get_current_scene().add_child(summon)
		$close.start(2)


func _on_close_timeout():
	queue_free()
