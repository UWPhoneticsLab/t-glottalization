#!/usr/bin/env python3

import glob
import os
from cmu_freq import cmu_ordered_by_frequency

order_map = {item: i for i, item in enumerate(cmu_ordered_by_frequency)}

all_words = []
all_words_sorted = []

for file_path in glob.glob('word-candidates/*'):
    name = os.path.basename(file_path)[:-4]
    with open(file_path,'r') as f:
        words = f.read().strip().split('\n')
    
    if name.endswith('sorted') or name.startswith('all'):
        # avoid sorting a sorted file
        continue
        
    sorted_items_with_rank = [(word, order_map.get(word, None)) for word in words]
    sorted_items_with_rank.sort(key=lambda x: x[1] if x[1] is not None else float('inf'))
    
    if name.endswith('N'):
        # only add to allwords if it's one of the glottalized rules (have to end in N)
        all_words += words
        all_words_sorted += sorted_items_with_rank
    with open(f'word-candidates/{name} sorted.txt','w') as f:
        f.write('\n'.join([f'{word}\t{rank}' for word,rank in sorted_items_with_rank])+'\n')
        
all_words_sorted.sort(key=lambda x: x[1] if x[1] is not None else float('inf'))
with open('word-candidates/all_words.txt','w') as f:
    f.write('\n'.join(sorted(all_words))+'\n')
with open('word-candidates/all_words sorted.txt','w') as f:
    f.write('\n'.join([f'{word}\t{rank}' for word,rank in all_words_sorted])+'\n')