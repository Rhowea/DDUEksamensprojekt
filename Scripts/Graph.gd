extends Control

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

func setBarHeight(income):
	for n in income:
		if income[n] == 0:
			bars[n].rect_min_size.y = 10
			labels[n].text = "0"
		else:
			bars[n].rect_min_size.y = (income[n] / 10) * ($Bars.rect_size.y / 500)
			labels[n].text = String(int(income[n]))
			print(bars[n].rect_min_size.y)
	for each in bars:
		bars[each].rect_pivot_offset.y = bars[each].rect_min_size.y

func playAnim():
	animPlayer.play("Grow")
