extends CanvasLayer

@onready var player = get_tree().get_current_scene().get_node("boat")
@onready var world = get_tree().get_current_scene()
@onready var lake = get_tree().get_current_scene().get_node("lake")
# Called when the node enters the scene tree for the first time.
func _ready():
	addinfo("Welcome to the lake")

# Called every frame. 'delta' is the elapsed time since the previous frame.

func addinfo(text = ""):
	print(text)
	$info.visible = true
	$info/Panel/RichTextLabel.newline()
	$info/Panel/RichTextLabel.text += "\n" + text 
	$Hideinfo.start(15)
	

func _process(delta):
	if Input.is_action_just_pressed("info"):
		$info.visible = true
		$Hideinfo.start(15)

func refresh(player):
		$Container/Mana_text.text = str(player.manabottle)
		$Container/Money_text.text = str(player.money)
		$Container/Fish_text.text = str(player.fish)
		$Container/ManaBar.value = player.mana
		$Container/ManaBar.max_value = player.maxmana
		$Container/Level_label.text = "Level: " + str(player.level)
		if player.level > 1 :
			$Container/Level2.visible = true


func _on_hideinfo_timeout():
	$info.visible = false
