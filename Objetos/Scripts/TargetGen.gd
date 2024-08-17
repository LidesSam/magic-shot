extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var preloadT = preload("res://Objetos/Target.tscn")
var preBomb = preload("res://Objetos/Bomb.tscn")

var coulddown = 0
var bcoulddown = 0

var deadCoulddown = 0
export var time_into_gen=3
var count =0

var ToNextLevel = 5
var targets_d 
export var minTargetSpeed = 0.25

export var genMinDistance = 8
var maxnbomb=1
var bcount=0
var Score=0
var Start = false
var StartCoulddown
func _ready():
	StartCoulddown=4
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	resetDeadCoulddown()
	targets_d=0
#alling position with the bullet
	var p = get_parent().get_node("Player")
	var pos = p.translation
	pos += Vector3(0,p.get_node("BulletPos").translation.y,0)
	self.translation= pos
#	_AddNewTarget()


func resetDeadCoulddown():
	deadCoulddown = ToNextLevel * time_into_gen 
	if deadCoulddown<=10:
		deadCoulddown=10
	if deadCoulddown>=20:
		deadCoulddown=20
	print("resetdCouldoansd")
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if Start:
		deadCoulddown-=delta
	
		if(deadCoulddown<=0):
				get_parent().get_node("Player").lostLife()
				
				
		global.timeLeft=int(deadCoulddown)
		
		coulddown-=delta
	
		if (coulddown<=0 and count<6) or (count<1 and coulddown<=1): 
						coulddown = time_into_gen
						count+=1
						_AddNewTarget()
	#					_AddNewBomb()
					
		
		bcoulddown-=delta
	
		if (bcoulddown<=0 and bcount<maxnbomb): 
						bcoulddown = time_into_gen*1.5
						bcount+=1
						_AddNewBomb()
						
		
		
		
		global.setDataLevelStr(get_target_counter())
	else:
		if StartCoulddown<=0:
			get_node("CountDown").visible=false
			Start=true
		else:
			StartCoulddown-=delta
			get_node("CountDown").text = str(int(StartCoulddown))
	
func get_target_counter():
	var couter_str = ""
	couter_str=str(targets_d,"/",ToNextLevel)
	return couter_str

func _AddNewTarget():
	
	var nt = preloadT.instance()
	nt.visible=false
	
	var r = (randi()%12)*360/24
	
	var level = global.level
	#random size(more small)
	if(level<=3):
		
		nt.set_scale(Vector3(2,2,2))
	else:
		var rs = randi()%3
		var rscale = 1 + 0.5*rs
		print("rscale: ",rscale)
		nt.scale(Vector3(rscale,rscale,rscale))
	if(nt.has_method("set_ini")):
		nt.set_ini(r,10)
		
		
		var rspeed = randi()%level+1
		var dir = randi()%2
		var tspeed = minTargetSpeed+level*0.2
		print(str("Tspeed:",tspeed))
		if(dir==0):
			tspeed *=-1
			
		#add vertical speed for diagonal movement
		if level>=2:
			var vspeed = 1+ randi()%(level-1)* 0.25 
			nt.set_vertiacalSpeed(vspeed)
		

	add_child(nt)
		
	
func _AddNewBomb():
	var nb = preBomb.instance()	
	var r = (randi()%12)*360/12
	nb.set_angleini(r)
	add_child(nb)
	
func TargetSignal():
	targets_d+=1
	count-=1
	global.score+=50
	if (targets_d>= ToNextLevel):
		global.score+=500
		global.EnddlesNextLevel()
		targets_d=0
		if global.level==2:
			maxnbomb=2
			
		ToNextLevel+=4
	
	resetDeadCoulddown()
		
func BombSignal(var explotion =false):
	bcount-=1
	global.score+=80
	if(explotion):
		get_parent().get_node("Player").lostLife()
	resetDeadCoulddown()
