extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Score_text.text = "Score:" + str(Game.score)
	$Panel/Score_text.text += "\n" + Game.endmessage
	$Panel/Score_text.text += "\n\nLevel: " + str(Game.endlevel)
	$Panel/Score_text.text += "\nBottles: " + str(Game.endmanabottle)
	$Panel/Score_text.text += "\nfish: " + str(Game.endfish)
	$Panel/Score_text.text += "\nCoins: " + str(Game.endmoney)
	#$Panel/Score_text.text = "\n" + Game.message
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_level_pressed():
	Game.upLevel()


func _on_main_menu_pressed():
	Game.mainMenu()
