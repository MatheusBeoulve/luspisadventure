extends Node

func _ready():
	assert($LupiSpaceship.connect("shoot", self, "_on_lupi_shoot") == 0)
	assert($MotherLair/MotherCheese.connect("shoot", self, "_on_mother_shoot") == 0)
	$MotherLair.position.x = get_viewport().size.x / 2
	$MotherLair.position.y += 60

func _on_lupi_shoot(Carrot, location):
	var carrot = Carrot.instance()
	carrot.position = location	
	add_child(carrot)

func _on_mother_shoot(Cheese, location):
	var cheese = Cheese.instance()
	cheese.position = location
	add_child(cheese)
