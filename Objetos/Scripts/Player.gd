extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var bullet =preload("res://Objetos/basicBullet.tscn")
var collision_exception = []
var coulddown = 0
#time between shots
export var timeBshot =0.5
var limitSpeed = 5
var aceleration =0

export var life=3
var maxlife=5

var rspeed = 0;
var dir = 0

var speed = 0.5
var lastKey = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	coulddown=0
	if life>maxlife:
		life= maxlife
	
		
	
	var node = get_tree().get_root().get_node("Node").get_node("Gui")
	if not (node == null):
#		print("ldie")
		node.get_node("Minimap").SetPlayer(self)
	else:
		print("nulll")
	
	pass
	
func lostLife(dmg=1):
	life-=dmg
	if life<=0:
#		print("loss!")
		global.Loss()
		get_node("LossLiveSfx").play()
func Heal(points=1):
	life+=points
	if(life>maxlife):
		life=maxlife
func _process(delta):
			
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

	if get_node("AnimationPlayer").is_playing():
		get_node("AnimationPlayer")
	if Input.is_action_just_pressed("cnfg_Left"):
		lastKey=1
		
	if Input.is_action_just_pressed("cnfg_Right"):
		lastKey=2
	
#	#normal movement
	rspeed=0
	
	if (Input.is_action_pressed("cnfg_Left") and lastKey==1 ):
		rspeed += limitSpeed

	if (Input.is_action_pressed("cnfg_Right") and lastKey==2):
		rspeed -= limitSpeed
#	#soap movement
	
		
#	if (Input.is_action_pressed("cnfg_Left") and lastKey==1 ):
#		rspeed+=(speed*delta)
#		if rspeed>limitSpeed:
#			rspeed=limitSpeed
#
#
#
#	if (Input.is_action_pressed("cnfg_Right") and lastKey==2 ):
#		rspeed-=(speed*delta)
#		if rspeed<-limitSpeed:
#			rspeed=-limitSpeed
#
##
#	if not Input.is_action_pressed("cnfg_Left") && not Input.is_action_pressed("cnfg_Right") && rspeed != 0 :
#
#		if (rspeed<=0.5):
#			if rspeed>= -0.5:
#				rspeed=0
#			else:
#				rspeed+= delta*speed*1.5
#
#		else:
#			rspeed-= delta*speed*1.5
			
	
	
	

			
	if (coulddown>0):
		coulddown-=delta
	else:
		if Input.is_action_just_pressed("cnfg_Action"):
			
			get_node("AnimationPlayer").play("WandShotFhalf")
			
			coulddown= timeBshot

		
	self.rotate_y(rspeed*delta)
#	self.rotate(rot,10*delta)
#pass
func GetMaxLife():
	return maxlife
	
func GetLife():
	return life
	


func _on_AnimationPlayer_animation_finished(anim_name):
	print(str("anim_name: ",anim_name))
	
	if anim_name=="WandShotFhalf":
		get_node("Shot").play()
		var b = bullet.instance()
		b.translate(to_global(get_node("BulletPos").translation))
		if b is preload("res://Objetos/Scripts/Bullet.gd"):
			b.set_velocity(get_global_transform().basis.z*10)
			get_tree().get_current_scene().add_child(b)
			coulddown= timeBshot
	get_node("AnimationPlayer").play("Stand")
	pass # replace with function body
