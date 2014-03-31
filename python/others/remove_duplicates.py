def remove_duplicates(lst):
	b = []
	for i in lst:
		if i not in b:
			b.append(i)
	return b

print remove_duplicates([2, 2, 3, 3, 4, 4, 5, 5]);
