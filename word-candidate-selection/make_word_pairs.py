#!/usr/bin/env python3

import numpy as np


# one list for eil, one for ell, and one for t-glottalization
wordlists = ['EY L #orCX', 'EH L #orCX', 'all_words']

def block_duplicates(text):
	split_text = [t.split('\t') for t in text.split('\n')]
	words = [t[0].split('_')[0] for t in split_text]
	unique_words = set(words)
	keep_idxs = []
	discard = []
	for i, word in enumerate(words):
		if word in discard:
			continue
		if words.count(word) > 1:
			discard.append(word)
		keep_idxs.append(i)
	text = '\n'.join(np.array(text.split('\n'))[keep_idxs].tolist())
	return text

def process_wordlist(text):
	'''Take a text file with words sorted by rank, and compare the
	relative rank of words'''
	text = block_duplicates(text)
	text = text.split('\n')
	pairs = []
	for i in range(0,len(text)-1, 2):
		(w1,r1),(w2,r2) = text[i].split('\t'),text[i+1].split('\t')
		if r1 == 'None' or r2 == "None":
			diff = 'n/a'
		else:
			diff = int(r2)-int(r1)
		pairs.append(f'{w1}\t{w2}\t{diff}')
		# import pdb;pdb.set_trace()

	return '\n'.join(pairs)


def main():
	for word in wordlists:
		filename = f'word-candidates/sorted/{word} sorted.txt'
		with open(filename,'r') as f:
			raw_text = f.read().strip()
		for_printing = process_wordlist(raw_text)
		with open(f'word-candidates/pairs/{word}.txt','w') as f:
			f.write(for_printing+'\n')
if __name__ == "__main__":
	main()
