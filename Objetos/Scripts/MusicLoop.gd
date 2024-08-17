extends AudioStreamPlayer

#add to a audio player to play in loop the music
var originalVol =0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#add code for set volumne
	#volumme
	#self.volume_db = global.musicVol
	
	pass

func _process(delta):
	# when the music stop
	# call to play again 
	if self.playing==false:
		self.play(true)
