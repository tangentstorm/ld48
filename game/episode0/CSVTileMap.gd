tool extends Node2D

export(NodePath) var target : NodePath 
export(String, FILE, "*.txt") var csv
export(bool) var go = false setget _go


func read_grid(path):
	var f = File.new()
	var g = []
	f.open(self.csv, File.READ)
	for line in f.get_as_text().split("\n"):
		if line != "":
			var row = []
			for cell in line.split(","):
				if cell != "":
					row.push_back(int(cell))
			g.push_back(row)
	return g

	
# I don't know how else to make a button run the code.
# Using an "onclick" didn't seem to work in the editor.
func _go(checked:bool):
	if checked:

		var tileMap : TileMap = get_node(target)
		tileMap.clear()
		var y = 0
		for row in read_grid(self.csv):
			var x = 0
			for val in row:
				print(val)
				tileMap.set_cell(x,y,val)
				x += 1
			y += 1
		
		self.set("go", false)
