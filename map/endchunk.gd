extends Node2D

@onready var ui = get_tree().get_current_scene().get_node("mainui")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Node2D/Endgoal2/PanelContainer/Panel/RichTextLabel.text = "You need " + str(Game.bottleneed) + " To finish level"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "boat":
		print("goal reached")
		if get_tree().get_current_scene().get_node("boat").manabottle >= Game.bottleneed:
			print("welcome to summoner fest")
			Game.endgame(body.fish,body.money,body.level,1.2,body.manabottle,"You reach summoner Fest")
		else:
			ui.addinfo("Come back when you have enough mana bottle!")
