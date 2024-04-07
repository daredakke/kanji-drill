extends Node


var start: int = 1
var end: int = 2200
var questions: int = 100


func valid_setup_values() -> bool:
	if start > end:
		return false
	
	return true
