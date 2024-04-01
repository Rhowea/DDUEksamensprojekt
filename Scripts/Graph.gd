extends Control

onready var bars := {
	0: $Bars/ColorRect1,
	1: $Bars/ColorRect2, 
	2: $Bars/ColorRect3, 
	3: $Bars/ColorRect4, 
	4: $Bars/ColorRect5, 
	5: $Bars/ColorRect6, 
	6: $Bars/ColorRect7,
}

onready var labels := {
	0: $Bars/ColorRect1/Label1,
	1: $Bars/ColorRect2/Label2,
	2: $Bars/ColorRect3/Label3,
	3: $Bars/ColorRect4/Label4,
	4: $Bars/ColorRect5/Label5,
	5: $Bars/ColorRect6/Label6,
	6: $Bars/ColorRect7/Label7,
	
}

func setBarHeight(income):
	var highest = 0
	for n in income:
		if income[n] > highest:
			highest = income[n]
	if highest != 0:
		for n in income:
			bars[n].rect_min_size.y = 180 * (income[n]/highest)
			labels[n].text = String(int(income[n]))
	else:
		for n in income:
			bars[n].rect_min_size.y = 0
			labels[n].text = String(int(income[n]))
