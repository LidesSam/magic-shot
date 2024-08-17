extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (StreamTexture) var spr 
export (StreamTexture) var pspr 
export (StreamTexture) var bspr 


var pmark = Sprite.new()
var tgmarks = []
var tgList = []
var bmarks = []
var bList = []
var aux= true
var _player = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	pmark.set_texture(pspr) 
	var pos = Vector2(0,0)
	pos.x=get_rect().size.x/2
	pos.y=get_rect().size.y/2
	pmark.position = pos
	rect_pivot_offset = Vector2(get_rect().size.x/2,get_rect().size.y/2)
	add_child(pmark)
	pass

func _process(delta):
		
	if not(_player==null):
		pmark.global_rotation_degrees = 0
		self.set_rotation(deg2rad(_player.rotation_degrees.y+180))
	MarksUpdate()
	
func MarksUpdate():
	var i = 0 
#targets	
	for sprite in tgmarks:
#			print(str("i: ",i," tgsize: ",tgList.size()))
		if i<tgList.size():
			
			sprite.show()
			var pos = Vector2(0,0)
			pos.x=tgList[i].translation.x*4+get_rect().size.x/2
			pos.y=tgList[i].translation.z*4+get_rect().size.y/2
			sprite.position = pos
#fixed graffic error	
			if not(_player==null):
				sprite.set_rotation(deg2rad(0-_player.rotation_degrees.y+180))
			
			sprite.visible=true
		else:
#				print("Hide")
			sprite.visible=false
		i+=1
		
#bombs	
	i = 0 
	for sprite in bmarks:
#			print(str("i: ",i," tgsize: ",tgList.size()))
		if i<=bList.size():
			
			sprite.show()
			var pos = Vector2(0,0)
			pos.x=bList[i].translation.x*4+get_rect().size.x/2
			pos.y=bList[i].translation.z*4+get_rect().size.y/2
			sprite.position = pos
			sprite.frame = bList[i].get_frame()
			sprite.visible=true
#fixed graffic error	
			if not(_player==null):
				sprite.set_rotation(deg2rad(0-_player.rotation_degrees.y+180))
			
		else:
#				print("Hide")
			sprite.visible=false
		i+=1
	
func addTgList(target):
	if target is preload("res://Objetos/Scripts/Target.gd"):
		tgList.push_front(target)
		var nspr = Sprite.new()
		nspr.set_texture(spr) 
		tgmarks.push_front(nspr)
		#call for fix visual error(it se the sprite in the position (0,0) when is added)
		MarksUpdate()
		add_child(nspr)
	
func removeTgList(target):
#	aux=false
	if target is preload("res://Objetos/Scripts/Target.gd"):
		var i=0
		for tg in tgList:
			if(tg == target):
#				print(str("i: ",i))
				tgList.remove(i)
				var tgmark = tgmarks[i]
				tgmarks.remove(i)
				remove_child(tgmark)
			i+=1

func addBombList(Bomb):
	if Bomb is preload("res://Objetos/Scripts/Bomb.gd"):
		bList.push_front(Bomb)
		var nspr = Sprite.new()
		nspr.set_texture(bspr) 
		bmarks.push_front(nspr)
		nspr.hframes=3
		#call for fix visual error(it se the sprite in the position (0,0) when is added)
		MarksUpdate()
		add_child(nspr)
	
func removeBombList(Bomb):
#	aux=false
	if Bomb is preload("res://Objetos/Scripts/Bomb.gd"):
		var i=0
		for b in bList:
			if(b == Bomb):
#				print(str("i: ",i))
				bList.remove(i)
				var bmark = bmarks[i]
				bmarks.remove(i)
				remove_child(bmark)
			i+=1
	
		
func SetPlayer(p = preload("res://Objetos/Player.tscn")):
	if p is preload("res://Objetos/Scripts/Player.gd"):
		_player=p
		get_parent().set_player(p)
		print("plyerset")
