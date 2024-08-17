extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var level=1
export var datalevelStr=""
export var Gui = preload("res://Objetos/System/Gui.tscn")
var guiSeted = false
var tonextLevel = 1
var target_destroyed =0
export var timeLeft = 15
export var could=""
export var score = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func Loss():
	
	get_tree().change_scene("res://Scenas/GameOverScreen.tscn")
	pass
func _reset_level():
	level = 0
	
func EnddlesNextLevel():
	level+=1
	print(str("nextLevel:",level))

func setDataLevelStr(text):
	datalevelStr=text
	
func setGui(GUI = null):
	if not(GUI == null):
		guiSeted=true
		Gui=GUI 
		print("Gui Seted")

func resetVars():
	guiSeted = false


		
