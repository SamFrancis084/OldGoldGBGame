extends Node

@export var current_score : int = 0:
	set(value):
		current_score = value
		score_changed.emit()

signal score_changed
