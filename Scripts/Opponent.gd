class_name Opponent

# Signals for interacting with the main level script
signal write_txt(txt)				# Signal for writing text upwards
signal comeback_score(score, ins)	# Signal for the score of a comeback
signal insult_score(score)			# Signal for the score of an insult

# Dialogue dictionaries
var insults = {
	"Insult": 0,
	"Insult 2": 1, 
	"Insult 3": 1,
	"Insult 4": 2
	}

var comebacks = {
	"Comeback 1": 2,
	"Comeback 2": 1,
	"Comeback 3": 3,
	"Comeback 4": 0
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
func comeback(insult_score: int):
	var keys = comebacks.keys()
	
	# Find the three closest matches to the insult
	var matches = []
	for key in keys:
		var diff = abs(insult_score - key)
		if diff < 3:
			matches.append(key)
	
	# Randomly select a comeback from the three closest matches
	var c_score = matches[randi() % 3]
	var c = comebacks[c_score]
	
	emit_signal("write_txt", c)
	emit_signal("comeback_score", c_score, insult_score)
