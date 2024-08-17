extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var _pause= false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	_process(true)
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("cnfg_pause"):
		if(_pause==false):
			_pause=true
			self.visible=true
			
		else:
			self.visible=false
			_pause=false	
		print("xxx")
		get_tree().set_pause(_pause)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
