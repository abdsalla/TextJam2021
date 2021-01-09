class_name Player

signal write_pl_txt(txt)

# Dialogue dictionaries
var insults = {
	"Insult 1": 0,
	"Insult 2": 1,
	"Insult 3": 2,
	"Insult 4": 2
	}

var comebacks = {
	"Comeback 1": 1,
	"Comeback 2": 0,
	"Comeback 3": 1,
	"Comeback 4": 2
	}
	
# Called at the start of the game (MainHandler's _ready function)
func start():
	emit_signal("write_pl_txt", "Hell yeah!")
