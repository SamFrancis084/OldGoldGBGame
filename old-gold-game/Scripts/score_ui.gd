extends Control

@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()
	PlayerScore.score_changed.connect(update_ui)


func update_ui():
	score_label.text = "Score: " + str(PlayerScore.current_score)
