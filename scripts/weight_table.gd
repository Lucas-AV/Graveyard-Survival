class_name WeightTable

var items: Array[Dictionary] = []
var total_weight: int = 0

func add_item(item, weight: int) -> void:
	items.append({"item": item, "weight": weight})
	total_weight += weight
	
func pick_random_item():
	var chosen_weight = randi_range(1, total_weight)
	var iteration_sum = 0
	for item in items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
