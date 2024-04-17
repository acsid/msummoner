extends RigidBody2D

@export var weight: int = 4
@export var timeAlive: int = 5
var enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = Vector2(randf_range(-400,400),-500)
	$AnimatedSprite2D.play("default")
	$Despawn.start(timeAlive)
	$tenable.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if linear_velocity.y > 0:
		enabled = true
	pass
	
	
	
func _on_area_2d_body_entered(body):
	if enabled:
		if body.name ==  "boat":
			body.get_fish(weight)
			queue_free()



func _on_despawn_timeout():
	queue_free()


func _on_tenable_timeout():
	enabled = true


func _on_test_timeout():
	linear_velocity.y = -250
