Used the following frames to generate candidate words at [https://sarablalockng.github.io/research/elicitations/make_wc.html](https://sarablalockng.github.io/research/elicitations/make_wc.html):

T N
VX1 L T AH0 N
VX1 N T AH0 N
VX1 R T AH0 N
VX1 T AH0 N

There are sorted and unsorted variants of these word candidates, where the sorting is done according to the lexical frequency from [English Gigaword Fifth Edition](https://catalog.ldc.upenn.edu/LDC2011T07).

The variants all_words and all_words sorted combine the words from all frames.

The gigaword frequencies are stored as an ordered list called `cmu_ordered_by_frequency` in the file `cmu_freq.py`.

The code can be rerun with the invocation `python3 sort_by_freq.py`.