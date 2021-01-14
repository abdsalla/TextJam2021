#*******************************************************************
# This is the main script for running the game.
#
# It has all the necessary functions for writing text, playing sound,
# and managing the main game scene.
#********************************************************************

extends Node2D

# Define nodes we will need access too
var opp_scroll: Label			# Scroll label for printing dialogue (opponent)
var player_scroll: Label		# Scroll label for printing dialogue (player)
var player_hlth_txt: Label		# Label for displaying player health
var opp_hlth_txt:	Label		# Label for displaying opponent health
var insults_list:	ItemList	# List of player selectable insults
var comebacks_list: ItemList	# List of player selectable comebacks
var pl_voice_blip
var opp_voice_blip
var start_time: float
var delta_count:= 0.0

# Script types
var Opponent = preload("res://Scripts/Opponent.gd")
var Player = preload("res://Scripts/Player.gd")

# Create new player and opponent objects on ready
onready var opponent = Opponent.new()
onready var player = Player.new()

# Other necessary variables
onready var player_health: int = 15	# Player health
onready var opp_health: int = 15	# Opponent health


# Writes the text one character at a time
func write_text_one_char(txt: String, charScroll: Label):
#	for c in txt:
#		text_scoll_sound()
#		charScroll.text = c
	charScroll.text = txt
		

# Plays a sound when scrolling through text
func text_scoll_sound():
	# First pick random range
	# List of sounds to play from
	pl_voice_blip.play()
	
	while pl_voice_blip.playing == true:
		pass
	

# Writes only the opponent text
func write_opponent_txt(txt: String):
	# Write to opponent dialogue box
	write_text_one_char(txt, opp_scroll)


# Writes only to the player text
func write_player_txt(txt: String):
	# Write to player dialogue box
	write_text_one_char(txt, player_scroll)


# Function for updating player health txt
func update_player_health():
	player_hlth_txt.text = "Player: " + str(player_health)


# Function for updating opponent health text
func update_opponent_health():
	opp_hlth_txt.text = "Opponent: " + str(opp_health)


# Calculate player damage based on opponent's comeback
func calc_player_damage(comeback_score: int, init_insult: int):
	var diff = abs(init_insult - comeback_score)
	
	if diff == 0:
		player_health -= 5
	elif diff == 1:
		player_health -= 2
	else:
		player_health -= 0
		
	if player_health < 0:
		player_health = 0
	
	update_player_health()


# Get the insult score for opponent's insult
func get_opponent_insult_score(insult_score: int):
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the child components
	opp_scroll = get_node("GrayTextScrollingBackground/Opponent_Scroll")
	player_scroll = get_node("GrayTextScrollingBackground/Player_Scroll")
	player_hlth_txt = get_node("GrayTextScrollingBackground/Player_Health")
	opp_hlth_txt = get_node("GrayTextScrollingBackground/Opponent_Health") 
	insults_list = get_node("BlackTextOptionBackground/Insults_List")
	comebacks_list = get_node("BlackTextOptionBackground/Comebacks_List")
	pl_voice_blip = get_node("GrayTextScrollingBackground/Player_Face/Voice Blip")
	opp_voice_blip = get_node("GrayTextScrollingBackground/Opponent_Face/Voice Blip")
	
	# Initialize the child components
	opp_scroll.text = ""
	player_scroll.text = ""
	player_hlth_txt.text = "Player: " + str(player_health)
	opp_hlth_txt.text = "Opponent: " + str(opp_health)
	
	### @Duli: Initialize the lists of comebacks and insults with defaults here ###
	
	# Connect the player and opponent scripts
	player.connect("pl_dia", self, "write_player_txt")
	player.start(player_scroll.text)
	opponent.connect("write_txt", self, "write_opponent_txt")
	opponent.connect("comeback_score", self, "calc_player_damage")
	opponent.connect("insult_score", self, "get_opponent_insult_score") 
	opponent.start()
	
	### @Duli: Do the same as lines 64 & 65 for the player to connect write signals ###

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta_count <= 0:
		start_time = delta
	delta_count += delta
	if delta_count - start_time > 3:
		write_player_txt("bibbity boop")
