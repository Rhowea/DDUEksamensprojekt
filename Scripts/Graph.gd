extends Control

var incomeLocal = [100, 200, 300, 400, 500, 600, 700]

onready var animPlayer = $Bars/AnimationPlayer

onready var bars = $Bars.get_children()

onready var labels: Array

func _ready():
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
	bars.erase($Bars/AnimationPlayer)
	for each in bars:
		labels.append(each.get_node("Label"))

func _on_viewport_size_changed():
	setBarHeight(incomeLocal)

func setBarHeight(income):
	incomeLocal = income
	for n in income.size():
		if income[n] == 0:
			setIndividualBar(bars[n], 10)
			labels[n].text = "0"
		else:
			setIndividualBar(bars[n], income[n])
			labels[n].text = String(int(income[n]))
	for each in bars.size():
		bars[each].rect_pivot_offset.y = bars[each].rect_min_size.y

func setIndividualBar(bar, income):
	bar.rect_min_size.y = $Bars.rect_size.y * (income / 8000)

func playAnim():
	animPlayer.play("Grow")
