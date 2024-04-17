extends Area2D
@onready var player = get_tree().get_current_scene().get_node("boat")
@onready var world = get_tree().get_current_scene()
var cansell = false
var cooldown = false
var vendor = null
@export var price = 100
@export var ratio = 2.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !cooldown:
		if Input.is_action_just_pressed("cast"):
			if get_tree().get_current_scene().get_node("boat").money >= price:
				if vendor == self:
					cooldown = true
					get_tree().get_current_scene().get_node("boat").money -= price
					get_tree().get_current_scene().get_node("boat").levelup()
					$Cooldown.start(price)
					price *= ratio
					$UI.visible = false



func _on_body_entered(body):
	if !cooldown && body.name == "boat":
		$UI.visible = true
		vendor = self


func _on_body_exited(body):
	$UI.visible = false


func _on_cooldown_timeout():
	cooldown = false
