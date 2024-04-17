extends TileMap

@export var vendorchunk = false
var vendor = preload("res://summon/vendor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	if vendorchunk:
		var inst = vendor.instantiate()
		add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bottle_timeout():
	pass # Replace with function body.
