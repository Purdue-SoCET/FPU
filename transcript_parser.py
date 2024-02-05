with open("transcript", "r") as file:
	lines = file.readlines()

total_error = 0
total_parsed = 0

for line in lines:
	if "[Input float]" in line:
		input_a = line[line.index(']') + 2 : line.index(']') + 18]
		input_b = line[line.index(']') + 21 : line.index(']') + 37]

	elif "Expected output:" in line:
		expected = line[line.index(':') + 2 : line.index(':') + 18]

		total_parsed += 1

	elif "Actual output:" in line:
		actual = line[line.index(':') + 2 : line.index(':') + 18]

		if (expected[-1] == '1') and (actual[-1] == '0'):
			continue
			print("Rounding error")
		else:
			print("Actual incorrect answer: %s + %s = %s (Actual: %s)" % (input_a, input_b, expected, actual))
			total_error += 1
		

print("Total errors parsed:", total_parsed)
print("Total errors remaining:", total_error)