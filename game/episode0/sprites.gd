tool extends Node2D

export(bool) var go = false setget _go

func _go(checked:bool):
	if checked:
		# remove all the children
		for n in get_children():
			remove_child(n)		
			n.queue_free()
		# add them back
		repopulate()
		self.set("go", false)

func at(x,y,which):
	var sprite : Node2D = $"../prefab".get_node(which).duplicate()
	sprite.position = Vector2(x,y)
	add_child(sprite)


func repopulate():
	at(165,15,"gray")
	at(165,165,"gray")
	at(135,345,"red")
	at(285,405,"red")
	at(315,435,"red")
	at(405,225,"red")
	at(375,405,"red")
	at(405,405,"red")
	at(375,375,"red")
	at(405,375,"yellow")
	at(435,375,"yellow")
	at(345,375,"orange")
	at(225,375,"purple")
	at(195,375,"purple")
	at(165,375,"purple")
	at(285,345,"cyan")
	at(285,315,"cyan")
	at(285,285,"cyan")
	at(255,375,"red")
	at(225,225,"orange")
	at(135,225,"orange")
	at(135,315,"green")
	at(375,255,"blue")
	at(315,345,"yellow")
	at(135,165,"gray")
	at(45,405,"blue")
	at(105,405,"gray")
	at(15,15,"gray")
	at(255,465,"gray")
	at(285,135,"gray")
	at(105,15,"gray")
	at(375,15,"gray")
	at(45,15,"gray")
	at(75,45,"gray")
	at(165,135,"gray")
	at(195,15,"gray")
	at(255,15,"gray")
	at(75,15,"gray")
	at(315,165,"gray")
	at(285,15,"gray")
	at(405,15,"gray")
	at(435,15,"gray")
	at(465,15,"gray")
	at(45,315,"gray")
	at(75,375,"gray")
	at(315,285,"green")
	at(285,255,"cyan")
	at(345,315,"red")
	at(375,345,"red")
	at(255,135,"green")
	at(45,45,"gray")
	at(75,345,"gray")
	at(105,375,"gray")
