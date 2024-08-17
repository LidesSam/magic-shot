extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (StreamTexture) var h1texture
export (StreamTexture) var h2texture 
export (StreamTexture) var h2Atexture 
var index=0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_node("HelpRect").texture=h1texture
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
# provitional for only have 2 screens
func Changeimg():
	#note: change the backgroud color of the help images
	if index==0:
		if OS.get_name()=="Android":
			get_node("HelpRect").texture=h2Atexture
		else:
			get_node("HelpRect").texture=h2texture
		
		index=1
	else:
		
		get_node("HelpRect").texture=h1texture
	
		index=0
	
func _on_ButtonR_pressed():
# 	previousHelp()	
	Changeimg()

func _on_ButtonL_pressed():
#	nextHelp()	
	Changeimg()

func nextHelp():
	pass
func previousHelp():
	pass
