#!/usr/bin/env python3

import glob
import os
from cmu_freq import cmu_ordered_by_frequency

order_map = {item: i for i, item in enumerate(cmu_ordered_by_frequency)}

all_words = []
all_words_sorted = []

for file_path in glob.glob('word-candidates/*'):
    with open(file_path,'r') as f:
        words = f.read().strip().split('\n')
    all_words += words
    sorted_items_with_rank = [(word, order_map.get(word, None)) for word in words]
    all_words_sorted += sorted_items_with_rank
    sorted_items_with_rank.sort(key=lambda x: x[1] if x[1] is not None else float('inf'))
    name = os.path.basename(file_path)[:-4]
    with open(f'word-candidates/{name} sorted.txt','w') as f:
        f.write('\n'.join([f'{word}\t{rank}' for word,rank in sorted_items_with_rank])+'\n')
        
all_words_sorted.sort(key=lambda x: x[1] if x[1] is not None else float('inf'))
with open('word-candidates/all_words.txt','w') as f:
    f.write('\n'.join(sorted(all_words))+'\n')
with open('word-candidates/all_words_sorted.txt','w') as f:
    f.write('\n'.join([f'{word}\t{rank}' for word,rank in all_words_sorted])+'\n')