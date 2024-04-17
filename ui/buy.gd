extends Control

@onready var player = get_tree().get_current_scene().get_node("boat")
@onready var world = get_tree().get_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().canbuy:
		if Input.is_action_pressed("cast"):
			if get_tree().get_current_scene().get_node("boat").money >= 2:
				print("buy 1 mana")
				get_tree().get_current_scene().get_node("boat").money -= 2
				world.spawn_mana(get_parent().get_node("spawn_obj").global_position)
