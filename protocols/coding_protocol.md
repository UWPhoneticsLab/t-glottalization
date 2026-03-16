# Coding Protocol for the Utah /t/-Glottalization Study

## 1. Overview

This protocol outlines the procedures for annotating audio recordings from a sociolinguistic study of **Utah English**. The study investigates the realization of /t/ in contexts where **/t/-glottalization** may occur, with particular attention to how **surprisal and attention to speech (monitoring)** influence the likelihood of hypercorrection or hypocorrection.

The study consists of two speech tasks:

* A **Labovian sociolinguistic interview**
* A **sentence-reading task**

The primary linguistic variable is **/t/-glottalization**, which may be realized as:

* [t]  (alveolar stop)
* [tʰ] (aspirated alveolar stop)
* [ʔ]  (glottal stop)
* creaky or glottalized phonation

A second variable, the **FAIL–FELL vowel merger**, is included as a **non-stigmatized dialect control variable**.

Annotation is conducted in **Praat** using a standardized **TextGrid structure**. Each annotated token corresponds to one observation in the coding spreadsheet used for statistical analysis.

Importantly, annotators code **only observable phonetic and contextual properties**. Theoretical interpretations (e.g., hypercorrection, monitoring level, surprisal) are derived later during analysis.

---

## 2. Required Software

Annotators should use the following tools:

* **Praat** (latest stable version)
* The project **TextGrid template**
* The **coding spreadsheet template**

Audio should be reviewed using **closed-back headphones** to ensure accurate identification of glottalization and phonation patterns.

---

## 3. Annotation Workflow

Each recording should be processed using the following workflow.

### Step 1: Open the recording

Load the `.wav` audio file and its associated **TextGrid template** in Praat.

### Step 2: Locate target tokens

Navigate through the recording and identify tokens containing:

* potential **/t/-glottalization environments**
* **FAIL–FELL vowel environments**

Each token should be marked as an **interval** in the `target_word` tier.

### Step 3: Annotate contextual information

For each token, fill in the relevant tiers describing:

* discourse context
* phonological environment
* phonetic realization

---

## 4. TextGrid Tier Structure

The annotation TextGrid contains several tiers used to encode contextual and phonetic information. These tiers are located under the transcription tiers.

### Interval tiers

#### task

Indicates which part of the study produced the token.

| Value     | Description                                          |
| --------- | ---------------------------------------------------- |
| interview | speech produced during the sociolinguistic interview |
| reading   | speech produced during the sentence-reading task     |

---

#### discourse_type

This tier categorizes the conversational context of the token.

| Value     | Description                                         |
| --------- | --------------------------------------------------- |
| narrative | personal stories or memories                        |
| opinion   | expression of attitudes, beliefs, or preferences    |
| expertise | explanation of a skill, hobby, or area of knowledge |
| reading   | sentence-reading task                               |

##### Coding guidance

**Narrative**

Speaker recounts events or personal experiences.

Example:

> “Last summer I went hiking in the mountains and…”

---

**Opinion**

Speaker expresses beliefs, preferences, or evaluations.

Example:

> “I think Utah winters are actually pretty mild.”

---

**Expertise**

Speaker explains how to do something or discusses a topic they know well.

Examples:

* explaining how to snowboard
* describing how to fix a bike
* explaining how their job works
* describing how to cook a favorite dish

Expertise discourse typically occurs when the participant is **teaching, instructing, or explaining**.

---

**Reading**

Speech produced while reading sentences from the experimental list.

---

#### target_word

The orthographic form of the word containing the variable. Taken from the transcriptions. 

Examples:

```
mountain
Latin
rotten
fail
fell
```

---

#### variable

Indicates which linguistic variable the token represents.

| Value            | Description                              |
| ---------------- | ---------------------------------------- |
| t_glottalization | potential /t/-glottalization environment |
| fail_fell        | vowel merger variable                    |

---

#### realization

This tier records the **phonetic realization** of the variable.

##### For /t/-glottalization tokens

| Label   | Description                         |
| ------- | ----------------------------------- |
| t       | clear alveolar stop                 |
| glottal | glottal stop [ʔ]                    |
| creaky  | creaky or glottalized phonation     |
| unclear | token cannot be reliably classified |

---

##### For FAIL–FELL tokens

| Label    | Description              |
| -------- | ------------------------ |
| merged   | vowel realized as [fɛl]  |
| unmerged | vowel contrast preserved |
| unclear  | ambiguous realization    |

---

#### stress

Stress of the syllable containing the variable.

| Value      | Description                      |
| ---------- | -------------------------------- |
| stressed   | occurs in a stressed syllable    |
| unstressed | occurs in an unstressed syllable |

Coders should rely on **standard English stress patterns** unless the speaker clearly produces an alternate stress.

---

#### phon_env

Phonological environment surrounding the /t/.

Examples include:

| Code | Meaning            |
| ---- | ------------------ |
| V_N  | vowel before nasal |
| V_V  | intervocalic       |
| V_#  | word-final         |
| #_V  | word-initial       |

---

## 5. Acoustic Identification of /t/ Realizations

Coders should rely on both **auditory cues and spectrographic evidence**.

### Alveolar stop [t]

Indicators:

* clear closure
* burst release in spectrogram
* brief period of silence followed by release

### Alveolar stop [tʰ]

Indicators:

* clear closure
* burst release in spectrogram
* brief period of silence followed by release
* period of aspiration following the burst

### Glottal stop [ʔ]

Indicators:

* abrupt cessation of voicing
* absence of alveolar burst
* glottal closure visible in waveform


### Creaky voice realization

Indicators:

* irregular vocal fold vibration
* lowered amplitude
* creaky phonation around the target segment

---

## 6. Coding Ambiguous Tokens

If the token cannot be confidently classified:

```
realization = unclear
```

Coders should leave a brief explanation in the **notes tier**, such as:

* overlapping speech
* background noise
* unclear articulation

Ambiguous tokens may be excluded from analysis later.

---

## 7. Inter-Coder Reliability

To ensure reliability:

* **middle third of the interview portion** will be independently coded by two annotators.

Agreement will be evaluated using:

* **Cohen’s κ** for categorical variables
* percent agreement for realization categories

Discrepancies will be reviewed and resolved collaboratively.

---

## 8. Data Export

After annotation:

1. Extract token information from the TextGrid.
2. Enter token-level information into the coding spreadsheet.
3. Each token should correspond to **one row** in the spreadsheet.

Required fields include:

* speaker ID
* recording ID
* task
* discourse type
* target word
* variable
* realization
* phonological environment
* stress

**Surprisal values are merged later during statistical analysis.**

---

## 9. Derived Variables (Not Annotated)

Certain variables are calculated automatically during analysis.

### Monitoring level

Derived from discourse type:

| discourse_type | monitoring  |
| -------------- | ----------- |
| narrative      | low         |
| opinion        | medium      |
| expertise      | medium-high |
| reading        | high        |

---

### Hypercorrection vs. hypocorrection

For **/t/-glottalization tokens**:

| realization  | interpretation  |
| ------------ | --------------- |
| tʰ           | hypercorrection |
| t            | hypercorrection |
| ʔ            | hypocorrection  |
| creaky voice | hypocorrection  |

FAIL–FELL tokens serve as a **control variable** and are not interpreted in terms of hyper/hypocorrection.

---

## 10. Quality Control Checklist

Before submitting annotations, coders should verify:

- [ ] All target tokens are labeled
- [ ] Each token has a `variable` value
- [ ] Each token has a `realization` label
- [ ] Ambiguous tokens are marked `unclear`
- [ ] Discourse type is filled for every token

---

## 11. Annotation Metadata

Each TextGrid should include metadata in a notes tier:

```
coder_initials
annotation_date
protocol_version
```

This ensures traceability across annotation sessions.
