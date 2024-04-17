extends Node2D

var lakesize = 32
var maxlake = 70000 * 32
var lake1 = preload("res://map/chunk.tscn")
var lake2 = preload("res://map/chunkdark.tscn")
var lake3 = preload("res://map/chunkisland.tscn")
var endlake = preload("res://map/endchunk.tscn")
var lakemap = preload("res://summon/lakemap.tscn")

@onready var ui = get_tree().get_current_scene().get_node("mainui")

var mapinst = lakemap.instantiate()
var canbuy = false
var cansell = false
var lastchunk = -1024
var finalsize = 0
@export var minisland = 2
@export var minvendor = 1
@export var mindark = 1
# Called when the node enters the scene tree for the first time.
var island = 0
var dark = 0
var vendor = 0
func _ready():
	minisland *= Game.worldLevel
	minvendor *= Game.worldLevel
	mindark *= Game.worldLevel
	maxlake *= Game.worldLevel
	lakesize *= Game.worldLevel
	var finalLakesize = 0
	add_child(mapinst)
	print("Generating Lake...")
	var step = 1
	var incomplete = true
	while incomplete:
		var size = generate(step)
		step += 1
		if vendor >= minvendor && island >= minisland && dark >= mindark:
			incomplete = false
		if size >= maxlake:
			print("not valid")
			incomplete = true 
			step = 1
			lastchunk = -1024
			mapinst.queue_free()
			mapinst = lakemap.instantiate()
			add_child(mapinst)
			
		finalLakesize = size
		
			
	Game.spawn_player($Spawn_player.position)
	#Game.spawn_player(Vector2(finalLakesize -1024,0))
	print("Done!")
	lakeinfo()
	
func generate(step = 1):
	var chunkpos = 0
	for c in lakesize:
		var chunk = null
		var rnd = randi_range(0,10)
		var chunkT = lake1
		if c <= 2 && step <= 1:
			#print("s")
			rnd = 1
		if rnd <= 5:
			chunkT = lake1
			chunk = chunkT.instantiate()
		if rnd >= 6:
			chunkT = lake2
			chunk = chunkT.instantiate()
			dark += 1
		if rnd == 10:
			island += 1
			chunkT = lake3
			chunk = chunkT.instantiate()
			var rvendor = randi_range(0,1)
			if rvendor == 1:
				chunk.vendorchunk = true
				vendor += 1
		chunkpos = lastchunk + (32*32) 
		#print(str(chunkpos))
		chunk.position.x = chunkpos
		lastchunk = chunkpos
		mapinst.add_child.call_deferred(chunk)
	var chunk = endlake.instantiate()
	chunkpos = lastchunk 
	chunk.position.x = chunkpos
	lastchunk = chunkpos
	#print("summoner fest")
	mapinst.add_child.call_deferred(chunk)
	finalsize = lastchunk
	#get_parent().spawn_player(Vector2(finalsize -1024,0))
	
	return lastchunk
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func lakeinfo():
	ui.addinfo("Lakesize: "+ str(lastchunk) + " PX   Lake Level: "+ str(Game.worldLevel))
	ui.addinfo("Dark: " + str(dark) + " Island: " + str(island) + " Vendor: " + str(vendor))


func _on_buymana_body_entered(body):
	if body.name == "boat":
		canbuy = true
		$buy.visible = true


func _on_buymana_body_exited(body):
	
	canbuy = false
	$buy.visible = false

func _on_dock_body_entered(body):
	if body.name == "boat":
		cansell = true
		$Sell.visible = true



func _on_dock_body_exited(body):
	cansell = false
	$Sell.visible = false



func _on_elapsed_timeout():
	Game.timer +=1 # Replace with function body.
