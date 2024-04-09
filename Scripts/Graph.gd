extends Control

var incomeLocal = [100, 200, 300, 400, 500, 600, 700]

onready var animPlayer = $Bars/AnimationPlayer

onready var bars := {
	0: $Bars/ColorRect1,
	1: $Bars/ColorRect2, 
	2: $Bars/ColorRect3, 
	3: $Bars/ColorRect4, 
	4: $Bars/ColorRect5, 
	5: $Bars/ColorRect6, 
	6: $Bars/ColorRect7
}

onready var labels := {
	0: $Bars/ColorRect1/Label1,
	1: $Bars/ColorRect2/Label2,
	2: $Bars/ColorRect3/Label3,
	3: $Bars/ColorRect4/Label4,
	4: $Bars/ColorRect5/Label5,
	5: $Bars/ColorRect6/Label6,
	6: $Bars/ColorRect7/Label7
}

func _ready():
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")

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
	for each in bars:
		bars[each].rect_pivot_offset.y = bars[each].rect_min_size.y

func setIndividualBar(bar, income):
	bar.rect_min_size.y = $Bars.rect_size.y * (income / 8000)

func playAnim():
	animPlayer.play("Grow")
