extends Node


var score = 0
var time_score = 500

var save_score = preload("res://Scripts/SaveScore.gd")


func add_score():
	if time_score > 0:
		time_score -= 1


func monster_killed():
	score += 50


func game_finished():
	var new_save_score = save_score.new()
	Score.score = score + time_score
	
	if ResourceLoader.exists("res://Data/save_data.tres"):
		var total_scores = load("res://Data/save_data.tres")
		new_save_score.scores = total_scores.scores
		new_save_score.scores.append(score + time_score)
		new_save_score.scores.sort_custom(self, "custom_comparison")
		while len(new_save_score.scores) > 10:
			new_save_score.scores.pop_back()
	elif not ResourceLoader.exists("res://Data/save_data.tres"):
		new_save_score.scores.append(score)
		
	ResourceSaver.save("res://Data/save_data.tres", new_save_score)
	
	
func custom_comparison(a, b):
	if a > b:
		return true
	return false
