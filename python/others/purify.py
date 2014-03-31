def purify(lst):
	x = [];
	for i in lst:
		print i
		if i % 2 == 0:
			x.append(i)
	return x

print purify([4, 5, 5, 4, 3, 4, 5, 67, 2])
