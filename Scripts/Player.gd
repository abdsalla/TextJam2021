class_name Player

signal write_pl_txt(txt)

# Dialogue dictionaries
var insults = {
	0: "Insult 1",
	1: "Insult 2", 
	2: "Insult 3",
	3: "Insult 4"
	}

var comebacks = {
	0: "Comeback 1",
	1: "Comeback 2",
	2: "Comeback 3",
	3: "Comeback 4"
	}
	
# Called at the start of the game (MainHandler's _ready function)
func start():
	emit_signal("write_pl_txt", "Hell yeah!")
