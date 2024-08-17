extends RigidBody

# nd for optimization: try change collistion shape of the bullet for a raycast shape
var vel = Vector3(0,0,0)

export var gravity = 0
var max_velocity = 10
var coulddown = 3

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	
	coulddown-=delta
	if(coulddown<=0):
		get_parent().remove_child(self)
	
	
func _integrate_forces(state):
	
#	print("bulles")
	for i in range(state.get_contact_count()):
		var cc = state.get_contact_collider_object(i)
		
		if (cc):
			
			print (str("cc: "+ cc.get_name()) )
			if (cc is preload("res://Objetos/Scripts/Target.gd") or cc is preload("res://Objetos/Scripts/Bomb.gd")):
#				print("pass")
				cc.contact()
			queue_free()
		


func set_velocity(velocity = Vector3()):
	vel= velocity
	linear_velocity = velocity
	
