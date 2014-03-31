def median(lst):
	lst.sort()
	if len(lst) % 2:
		return lst[len(lst) / 2]
	else:
		return (lst[len(lst) / 2] + lst[len(lst) / 2 - 1]) / 2.


print median([2, 3, 345,4, 54 ,5,4,6])
print median([1])
print median([4,5,5,4])
