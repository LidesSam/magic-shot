extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var coulddown = 0
export var timetoExplode = 5
var light = OmniLight
var frame = 0
var die=false
var anglepos = 0


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	coulddown = timetoExplode
	light = get_node("OmniLight")
	light.light_color = Color(0,255,0)
	frame=0
	
	var node = get_tree().get_root().get_node("Node").get_node("Gui")
	
	if not (node == null):
		print("bomb add")
		node.get_node("Minimap").addBombList(self)
	else:
		print("nulll")
	
	locateIn()
	
func get_frame():
	return frame
	
func locateIn():
	var newpos=Vector2 (cos(deg2rad(anglepos-90)),sin(deg2rad(anglepos-90)))
	translation =Vector3(newpos.x*12,0,-newpos.y*12)
	rotation = Vector3(0,deg2rad(anglepos-180),0)
	visible=true
	
	

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if die==true:
		self.visible=false
		if get_node("explotionSfx").playing==false:
			_die()
	else:
		coulddown-=delta
		if(coulddown<=0):
			die=true
			get_parent().BombSignal(true)
			get_node("explotionSfx").play()
			
		if coulddown<=(timetoExplode/4):
				frame=2
				light.light_color = Color(255,0,0)
		else:
			if coulddown<=(timetoExplode/2):
				frame = 1
				light.light_color = Color(255,255,0)
				
		
func contact():
	die=true
	get_parent().BombSignal(false)


func set_angleini(angle=180):
	anglepos=angle
	locateIn()
	
func _die():

	var node = get_tree().get_root().get_node("Node").get_node("Gui")
	
	if not (node == null):
		node.get_node("Minimap").removeBombList(self)
	else:
		print("nulll")
		
	get_parent().remove_child(self)
#	remove_and_skip()
