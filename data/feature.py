def feature_maker(filename,train):

	file_in = open(filename,'rt')
	file_out = open('feature_'+filename,'wt')

	#discard old header
	header = file_in.readline()
	##make new headers
	#if train:
		#print(','.join(["card1","card2","card3","card4","card5","suit1","suit2","suit3","suit4","target"]),file=file_out)
	#else:
		#print(','.join(["card1","card2","card3","card4","card5","suit1","suit2","suit3","suit4"]),file=file_out)
	
	for line in file_in:
		##get cards from the csv
		line = line.rstrip()
		row = line.split(',')
		row = [int(i) for i in row]
		card1 = row[0:2]
		card2 = row[2:4]
		card3 = row[4:6]
		card4 = row[6:8]
		card5 = row[8:10]
		
		#if test csv then get catagories
		if(train):
			poker_cat = row[10]
		
		##sort cards by the card value not suit
		hand = [card1,card2,card3,card4,card5]
		hand.sort(key=lambda x:x[1],reverse=True)

		#calculate difference between each card
		count_down = []
		for j in range(len(hand)-1):
			count_down.append(hand[j][1]-hand[j+1][1])
		count_down.append(abs(hand[len(hand)-1][1]-hand[0][1]))
		
		count_down = [str(j) for j in count_down]
		
		##make a dictionary of all possible suits and get summary of suits
		count_dict = dict()
		count_dict[1] = 0
		count_dict[2] = 0
		count_dict[3] = 0
		count_dict[4] = 0
		# read the contents
my_dna = file_in.read()
# calculate the length
dna_length = len(my_dna)
# print the output
print("sequence is " + my_dna +  " and length is " + str(dna_length))

		
	file_in.close()
	file_out.close()

feature_maker('train.csv',True)
feature_maker('test.csv',False)