class_name Opponent

# Signals for interacting with the main level script
signal opp_dia(txt)				# Signal for writing text upwards
signal comeback_score(score, ins)	# Signal for the score of a comeback
signal insult_score(score)			# Signal for the score of an insult

# Dialogue dictionaries
var insults = {
	"Insult 1": 0,
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
	var rand_insult = keys[randi() % keys.size()]
	var rand_key = insults.get(rand_insult)
	emit_signal("write_txt", rand_insult)
	emit_signal("insult_score", rand_key)


# Calculates the best comeback for a given insult 
func comeback(insult_score: int):
	var scores = comebacks.values()
	var dialogue = comebacks.keys()
	
	# Find the three closest matches to the insult
	var score_matches = []
	var comeback_matches = []
	for i in scores.size():
		var diff = abs(insult_score - scores[i])
		if diff < 3:
			score_matches.append(scores[i])
			comeback_matches.append(dialogue[i])
	
	# Randomly select a comeback from the three closest matches
	var idx = (randi() % 3)
	var c_score = score_matches[idx]
	var c = comeback_matches[idx]
	emit_signal("write_txt", c)
	emit_signal("comeback_score", c_score, insult_score)
