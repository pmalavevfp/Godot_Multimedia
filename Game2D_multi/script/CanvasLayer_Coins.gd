extends CanvasLayer


func _process(_delta):
	$Label.text=str(get_parent().coins)
	$Label2.text=str(get_parent().keys)
