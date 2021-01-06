class_name Opponent

# Signals for interacting with the main level script
signal write_txt(txt)			# Signal for writing text upwards
signal comeback_score(score)	# Signal for the score of a comeback
signal insult_score(score)		# Signal for the score of an insult

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
	emit_signal("write_txt", "Grrr!")


# Chooses a random insult
func insult():
	# Randomly select an item from the insults dictionary
	var keys = insults.keys()
	var rand_key = keys[randi() % keys.size()]
	var rand_insult = insults[rand_key]
	emit_signal("write_txt", rand_insult)
	emit_signal("insult_score", rand_key)


# Calculates the best comeback for a given insult 
func comeback(score: int):
	pass
