extends Node

@export var item_list : Array[Item]

func give_item(index : int) -> Item:
	if item_list.size() > 0 and item_list.get(index):
		return item_list[index]
	else:
		print_debug("Index not in item list")
		return 

func give_random_item() -> Item:
	if item_list.size() <= 0: return
	
	return item_list[randi_range(0, item_list.size() - 1)]
