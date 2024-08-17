extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_node("CenterContainer/Score").text = str("Your Score : ",global.score)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass




func _on_MainMenubtn_pressed():
	get_tree().change_scene("res://Scenas/Menu.tscn")
	


func _on_Restartbtn_pressed():
	pass # replace with function body
