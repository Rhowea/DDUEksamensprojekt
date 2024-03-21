extends Control

onready var bars := {
	0: $ColorRect1,
	1: $ColorRect2, 
	2: $ColorRect3, 
	3: $ColorRect4, 
	4: $ColorRect5, 
	5: $ColorRect6, 
	6: $ColorRect7,
}

onready var labels := {
	0: $ColorRect1/Label1,
	1: $ColorRect2/Label2,
	2: $ColorRect3/Label3,
	3: $ColorRect4/Label4,
	4: $ColorRect5/Label5,
	5: $ColorRect6/Label6,
	6: $ColorRect7/Label7,
	
}

func setBarHeight(income):
	var highest = 0
	for n in income:
		if income[n] > highest:
			highest = income[n]
	if highest != 0:
		for n in income:
			bars[n].rect_size.y = 150 * (income[n]/highest)
			labels[n].text = String(int(income[n]))
	else:
		for n in income:
			bars[n].rect_size.y = 0
			labels[n].text = String(int(income[n]))
