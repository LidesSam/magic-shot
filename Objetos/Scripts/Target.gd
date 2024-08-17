extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var distance = 0
var anglepos =0
#var move= GDScriptFunctionState
var radialSpeed = 1
var die=false
var VecticalSpeed=0

# discarted for the change of phisics in bullets
#var DeepthSpeed

var maxDeepth = 0
var minDeepth = 0
var posy=0
var incrY = 2
var dirY=1

#sinoideal var not currenly in use
#var sinX=0
#var dirX=1
#var displasamentY =0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	
#	move = LinearMove()
	die = false
	visible=false
	var node = get_tree().get_root().get_node("Node").get_node("Gui")
	
	if not (node == null):
		print("l")
		node.get_node("Minimap").addTgList(self)
	else:
		print("nulll")
	locateIn()


#func _process(delta):
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _process(delta):
	if( die):
		_die()
	anglepos+=radialSpeed
	if anglepos>=360:
		anglepos-=360
		
#	sig-zag movement
	if not (VecticalSpeed==0):
		posy+=incrY*dirY*delta
		if(dirY>0):
			if posy>=2:
					dirY=-1
		else:
			if (dirY<0):
				if posy<=-2:
					dirY=1
					
# senoideal movement
#	unused beacuse have similar effect to the sig zag movement and need more development
#	var sinYm = 2*sin(sinX*2)+1
##	print(str("sinYm: ", sinYm," dx: ",dirX," sinX: ",sinX))
#
#	if(dirX>0):
#		if sinX>=2:
#				dirX=-1
#		else:
#			if (dirX<0):
#				if sinX<=-2:
#					dirX=1
#
#
#
#	sinX+=delta*dirX
#	posy=sinYm
	
	locateIn()


func locateIn():
	var newpos=Vector2 (cos(deg2rad(anglepos-90)),sin(deg2rad(anglepos-90)))
	translation =Vector3(newpos.x*distance,posy,-newpos.y*distance)
	rotation = Vector3(0,deg2rad(anglepos-180),0)
	visible=true
	
func set_vertiacalSpeed(Vspeed):
	VecticalSpeed= Vspeed
	
	
func _integrate_forces(state):
	
	for i in range(state.get_contact_count()):
		var cc = state.get_contact_collider_object(i)
		var dp = state.get_contact_local_normal(i)
		
		print("holoa")
		if (cc):
			
			if (cc is preload("res://Objetos/Scripts/Bullet.gd") and not cc.disabled):
				set_mode(MODE_RIGID)
#				dying = true
				#lv = s.get_contact_local_normal(i)*400
#				state.set_angular_velocity(-dp.cross(up).normalized()*33.0)
#				get_node("AnimationPlayer").play("impact")
#				get_node("AnimationPlayer").queue("explode")
#				set_friction(1)
				cc.disabled = true
#				get_node("sound_hit").play()
				print("x")
				
func contact():
	die=true
	

func  set_ini(var angleIni=0, var _distance=0):
	anglepos = angleIni
	distance =_distance

	locateIn()


func get_pos_for_minimap():
	var minipos =  Vector2(self.translation.x,translation.z)
	return minipos
	
	
func _die():
	print("die")
	var node = get_tree().get_root().get_node("Node").get_node("Gui")
	get_parent().TargetSignal()
	if not (node == null):
		print("ldie")
		node.get_node("Minimap").removeTgList(self)
	else:
		print("nulll")
		
	get_parent().remove_child(self)
#	remove_and_skip()




