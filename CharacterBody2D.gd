extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var mana = 10
@export var maxmana= 10
@export var manabottle = 2
@export var move_cost = 0.01
@export var fish = 0
@export var money = 10
@export var level = 1
var cansommon = true
@onready var ui = get_tree().get_current_scene().get_node("mainui")
@onready var lake = get_tree().get_current_scene().get_node("lake")
var spawn = false
@onready var levelupsnd = preload("res://sounds/levelup.wav")

var cooldown_time = 2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var cast = 0

var castui = preload("res://cast.tscn")
func _ready():
	print("player ready")
	pass
	#position.x -= lake.lastchunk -1024

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction && mana > 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if get_node_or_null("Cast") == null:
		move_and_slide()

func _process(delta):
	if mana < 1 && manabottle < 1:
		Game.endgame(fish,money,level,manabottle,1,"Died from mana starving")
	if velocity.x != 0:
		mana -= 0.01
		if velocity.x > 0 :
			$AnimatedSprite2D.scale.x = -1
		if velocity.x < 0 :
			$AnimatedSprite2D.scale.x = 1
		$AnimatedSprite2D.play("moving")
	else:
		if get_node_or_null("Cast") == null:
			$AnimatedSprite2D.play("default")
	if get_node_or_null("Cast") == null:
		if Input.is_action_just_pressed("drink"):
			drinkMana()

		if Input.is_action_just_pressed("summon1"):
			if cansommon:
				$AnimatedSprite2D.play("summon")
				if mana >= 4:
					mana -= 4
					cast = randi_range(1,10)
					var uiInst = castui.instantiate()
						
					add_child(uiInst)
				else:
					ui.addinfo("Not enough mana Drink more (press: Q)")
			else:
				ui.addinfo("Cannot summon new creature")
		if Input.is_action_just_pressed("summon2") && level > 1:
			if cansommon:
				$AnimatedSprite2D.play("summon")
				if mana >= 10:
					mana -= 10
					cast = randi_range(5,20)
					var uiInst = castui.instantiate()
					uiInst.castwhat = 2
					add_child(uiInst)
				else:
					ui.addinfo("Not enough mana Drink more (press: Q)")
			else:
				ui.addinfo("Cannot summon new creature")
	updateUI()

func drinkMana():
	$cooldown.start(1)
	$Mana.visible = true
	$pickup_snd.play()
	if mana != maxmana && manabottle >= 1:
		mana += 25
		manabottle -= 1
	if mana > maxmana:
		mana = maxmana
	ui.addinfo("Mana drank (m)" + str(mana))
		
func get_fish(fishvalue):
	$pickup_snd.play()
	fish += fishvalue
	ui.addinfo("Picked up a fish")

func levelup():
	$levelup_snd.play()
	level += 1
	ui.addinfo("Level Up")
	maxmana *= 1.5
	move_cost *= 1.14
	SPEED *= 1.1

func pickMoney(value = 1):
	$money_snd.play()
	money += value
func updateUI():
	ui.refresh(self)


func _on_cooldown_timeout():
	$Mana.visible = false


func pickMana(value = 1):
	$pickup_snd.play()
	manabottle += value



func _on_area_2d_area_entered(area):
		if area.is_in_group("summon"):
			ui.addinfo("A summonned creature is near")
			cansommon = false


func _on_area_2d_area_exited(area):
		if area.is_in_group("summon"):
			print("summon far")
			cansommon = true
