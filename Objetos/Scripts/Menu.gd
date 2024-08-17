extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Screen = 0
var LastScreen = 1
var NextScree=""
var backbutton = Button
#var currentScreen= Node
#var lastScreen= Node
var change=false
var coulddown = 1
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	backbutton=get_node("BackButton")
#	currentScreen = get_node("Main")
#	lastScreen = get_node("Main")
	
	if( OS.get_name() == "Android"):
		get_node("Main/ConfigBtn").visible=false
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _process(delta):
	if change and get_node("Loading").visible:
		if(coulddown<=0):
			
			get_tree().change_scene("res://Scenas/EndlessLevel.tscn")
			#global.goto_scene("res://Scenas/EndlessLevel.tscn");
		else:
			coulddown-=delta	
	pass
	
func ChangeScreen(nextScreenId = 0):
	LastScreen= Screen
	Screen= nextScreenId

#	show the current screen

	match Screen:
	#main menu
		0:
			get_node("Main").visible= true 
			backbutton.visible=false
		1:
			get_node("Config").visible= true
		2:
			get_node("Help").visible=true
			pass 
			
#hide the last screen
	match LastScreen:
		0:
			get_node("Main").visible= false
			backbutton.visible=true
		1:
			get_node("Config").visible= false
			backbutton.visible=true
		2:
			get_node("Help").visible=false
			pass 
	


func _on_EndlessBtn_pressed():
	get_node("Main").visible=false
	get_node("Loading").visible=true
	change=true
	pass # replace with function body


func _on_BackButton_pressed():
	if backbutton.visible == true:
		backbutton.visible=false
		ChangeScreen(LastScreen)
	pass # replace with function body


func _on_ConfigButton_pressed():
	ChangeScreen(1)
	pass # replace with function body


func _on_HelpBtn_pressed():
	ChangeScreen(2)
	pass # replace with function body
