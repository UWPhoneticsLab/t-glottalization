# Transcription Protocol for the Utah /t/-Glottalization Study

## 1. Overview

This protocol outlines the procedures for automatically transcribing and correction transcriptons from a sociolinguistic study of **Utah English**. The study investigates the realization of /t/ in contexts where **/t/-glottalization** may occur, with particular attention to how **surprisal and attention to speech (monitoring)** influence the likelihood of hypercorrection or hypocorrection.

## 2. Automatic Transcription

### Making 30-second audio spans
The automatic speech recognition system works best on wav files that are no more than 30 seconds in duration. The python script `split_audio.py` is used to divide long wav files into chunks of around 30 seconds. This script first calls `ffmpeg` to get a listing of all spans of >=40ms with noise less than -35dB. Then, it determines which of these spans to use as split points, ensuring that no resultant audio is less than 15 seconds, and that splits are as close to 30 seconds in length as possible. Occaisionally if no silences are detected split wav files will be longer than 30 seconds.

`split_audio.py` takes three command-line arguments:
- input directory (`-i`)
- output directory (`-o`)
- file number to process (`-f`; for this study it is assumed that wav files are named using a 3-digit subject ID)

For example to process the first speaker:
```python
python3 split_audio.py -i wav_files -o split_wavs -f 1
```

### Processing with Crisper-Whisper

Transcription is done using [CrisperWhisper](https://github.com/nyrahealth/CrisperWhisper), an ASR tool touted for being able to produce high-quality word-level alignments alongside trascriptions.

The script `transcribe_utah_audio.py` has one dependency, the `utils.py` script from the CrisperWhisper repository. These scripts should be kept in the same folder.

`transcribe_utah_audio.py` requires four command-line arguments:
- `--indir`: where the split wav files are stored. This assumes the output organization of `split_audio.py`, where the split wavs from each speaker are stored in a subfolder of this directory
- `--outdir`: a folder to write pickles of transcription dictionaries to
- `--n`: the speaker number, equivalent to `-f` in `split_audio.py`
- `--i`: the index of the split wav to process, for example if 50 wavs were created in the previous step, `i` could be from 1 to 50.

Files were run individually to minimize memory constrains. A single NVIDIA H100 GPU was used to process individual files, with 6 GB of allocated memory to process batches of 5 split files at a time. The max runtime for a single speaker was set at 1hr, though in practice it only took a few minutes per run.

### Conversion to TextGrid

Transcriptions are stored as python dictionary in a binary format called a pickle. To convert to TextGrid, run

```python
python3 merge_textgrids.py -n {speaker number} -p {path to pickle directory}
```

To run this script for all speakers at once, you can use a loop in bash on the terminal:

```sh
for i in [1..26]; do
	python3 merge_textgrids.py -n $i -p {path to directory}
done
```

## 3. First pass correction

Each wav file has an associated textgrid. The textgrid has two tiers, labeled 'word' and 'utterance.' One researcher is assigned to each speaker for first-pass validation of transcription. 

Open wav file and TextGrid in Praat. Be sure to open the wav file as a long sound file. <!--Delete the `word` tier, by selecting the TextGrid in the object window, and using `Modify > Remove tier...` and the default number of 1.--> Rename the `utterance` tier to with the speaker number. For example speaker 001 should have tier name `001`. You can do this by selecting the TextGrid in the Praat Objects window, and clicking `Modify > Set tier name`, and renaming tier 2 appropriately.

Create an additional interval tier named `intvr` at position 3. You can do this by selecting the TextGrid in the Praat Objects window, and clicking `Modify > Insert interval tier...` or by using the keyboard shortcut `Ctrl+F3`.

Follow the transcription correction workflow:

1. View & Edit the textgrid and sound together. 
2. Select the first interval in the `{spkrno}` tier. Press tab to listen to the audio. 
3. If the transcription has an error, use the text window to correct in the utterance tier.
4. If the utterance was spoken by the interviewer, move it to the `ivr-utterance` tier: Keep the interval selected. Use `Ctrl+X` to move the tier's text to the clipboard, `Ctrl+3` to copy the boundaries to the interviewer tier (which should also select the new tier), and `Ctrl+V` to paste the text onto the new tier. Use `Alt+Up` to move back to the speaker tier. Caution: Do not use the circle button at the top of boundaries or the drag and drop functionality, as these operations are more likely to inadvertently shift boundary times.
5. If the utterance was partially spoken by the interviewer and partially by the speaker, delete the interval using `Alt+Backspace`. Use the intervals in the `word` tier to split up the utterance. You should use `Alt+Up` twice to move to the word tier, and then use `Alt+Left`, `Alt+Right`, `Ctrl+X`, and `Ctrl+2` or `Ctrl+3` as needed to move the word onto the correct tier. If consecutive words are moved to the same tier, click on the boundary between them and use `Alt+Backspace` to delete it and make a single interval.
6. Use `Alt+Up` or `Alt+Down` to get back to the speaker tier, and `Alt+Right` to move to the next interval.
7. Repeat steps 2-6 until you have listened to the entire file.

<!--Delete the `word` tier, by selecting the TextGrid in the object window, and using `Modify > Remove tier...` and the default number of 1.-->

Close the View and Edit window. Select the TextGrid in the Praat Objects window. Select `Save > Save as text file...` and save the file as `{spkrno}.TextGrid` in the location your PI has designated.

## 4. Correct proper nouns

Use the participant demographics document to-cross reference and correct Utah place names and other proper nouns in the first pass transcriptions by opening the TextGrid as a textfile and searching for capitalized terms using the regular expression `r'[A-Z]\w+'`. Note that this will also capture the beginning of sentences which may be ignored.

## 5. Force-align

Ensure that MFA is installed on your machine. Move corrected textgrids to the MFA corpus folder. Activate the conda environment, which will be called `aligner` if you've followed the installation instructions as written: `conda activate aligner`.

Use the following script to run alignment 

```mfa align {indir} english_mfa_arpa english_mfa_arpa {outdir} --speaker_characters 26```

Last edit 04/06/26