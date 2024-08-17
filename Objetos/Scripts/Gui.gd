extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var tgen=null
var _player = preload("res://Objetos/Player.tscn")
var lifebar = []
export (StreamTexture) var Ul_spr

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	_player=null
	global.setGui(self)
	if(get_parent().has_node("TargetGen")):
		tgen =	get_parent().get_node("TargetGen")
#		print("tgen found")
		
		
	else:
		print("No Found")
	
#	var lbl= Label.new()
#	lbl.set_text(str(global.level))
#	add_child(lbl)	
	set_process(true)
	

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	get_node("Level").text = str("Level:",global.level)
	get_node("NextLevelInfo/dataNextLbl").text = global.datalevelStr
	get_node("Time/timeLeftLbl").text = str(global.timeLeft)
	get_node("Score").text = str("Score: ",global.score)
	if(_player != null and lifebar.size()>0):
		pass
		for i in range(0,lifebar.size()):
			if i >= _player.GetLife():
				lifebar[i].visible= false
			else:
				lifebar[i].visible = true


func set_player(player):
	_player=player
	for i in range(0,_player.GetMaxLife()):
		print (str("lives i:",i))
		var spr = Sprite.new()
		spr.set_texture(Ul_spr) 
		spr.position = Vector2(i*Ul_spr.get_size().x,0)
		spr.centered = false
		lifebar.push_back(spr)
		get_node("Lifebar").add_child(spr)
		
		
