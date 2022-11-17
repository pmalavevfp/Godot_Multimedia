extends Node


var count_coins=0
var count_door=1
var count_lives=100
var count_keys=0

func _process(_delta):
	if count_lives<0:
		count_lives=0
	elif count_lives>100:
		count_lives=100
