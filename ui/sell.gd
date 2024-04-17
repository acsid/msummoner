extends Control

@onready var player = get_tree().get_current_scene().get_node("boat")
@onready var world = get_tree().get_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().cansell:
		if Input.is_action_pressed("cast"):
			if get_tree().get_current_scene().get_node("boat").fish >= 1:
				print("sell 1 fish")
				get_tree().get_current_scene().get_node("boat").money += 1
				get_tree().get_current_scene().get_node("boat").fish -= 1
				world.spawn_coin(get_parent().get_node("spawn_obj").global_position)
