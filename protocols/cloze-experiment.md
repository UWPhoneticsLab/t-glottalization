# Cloze Experiment Protocol (jsPsych + Prolific)

## 1. Objective

The purpose of this cloze experiment is to measure participants’ expectations about lexical content in sentence contexts. Participants read sentences with a missing word and provide the word they believe best completes the sentence.

The distribution of responses is used to estimate the predictability of target items within each context.

Cloze probabilities derived from these responses will be used to quantify contextual predictability for other experimental tasks.

---

# 2. Participants

Participants will be recruited through Prolific.

Eligibility criteria:

- Age 18 or older  
- Native speakers of American English
- Must have been born and raised in the United States

Target sample size: **30 participants**.

Participants will be automatically assigned to one of **two stimulus groups** using their Prolific ID.

---

# 3. Experimental Platform

The experiment will be implemented using **jsPsych** and hosted on [MindProbe](https://mindprobe.eu), a secure web server.

Participant IDs will be obtained from the Prolific URL parameter:

`PROLIFIC_PID`

Example experiment link:

`https://experimenturl.com?PROLIFIC_PID={{%PROLIFIC_PID%}}`

The Prolific ID will be used to **deterministically assign participants to one of two stimulus lists**.

---

# 4. Stimulus Lists

Two stimulus lists will be constructed:

| Group | Stimuli |
|---|---|
| Group A | Reading List A |
| Group B | Reading List B |

Within each group:

- sentence order will be the same as the reading lists
- each participant sees each sentence only once
- see `reading_list_protocol.md` for explanation of the 

---

# 5. Group Assignment Procedure

Participants will be assigned to Group A or Group B using a deterministic function applied to their Prolific ID.

Assignment rule (example):

`hash(PROLIFIC_PID) mod 2`

- result **0 → Group A**
- result **1 → Group B**

---

# 6. Procedure

1. Participants follow a Prolific link to the experiment.
2. The experiment retrieves the participant's Prolific ID.
3. The participant is assigned to Group A or B.
4. Participants read instructions explaining the cloze task.
5. Participants complete 2–3 practice trials of 4-5 sentences.
6. Participants complete the main task.

---

## Trial Structure

Example stimulus:

> The children listened carefully to the scary ___.

Participants type the word they believe best completes the sentence.

Instructions:

- Enter **one word only**
- Type the **first word that comes to mind**
- Avoid overthinking responses

The experiment takes approximately **5–10 minutes**.

---

# 7. Data Processing

Responses will be normalized before analysis:

- convert responses to lowercase
- remove punctuation
- standardize spelling variants where appropriate

Cloze probability is calculated as:

$$P(word|context) = \dfrac{\textit{responses producing word}}{\textit{total responses}}$$

---

# 8. Data Analysis

## Cloze Probability

$$P(word|context)$$

## Entropy



$$H = - Σ p(x) log p(x)$$

Entropy measures the uncertainty of the response distribution.

## Surprisal

$$Surprisal(word) = -log(P(word|context))$$

Higher surprisal values correspond to less predictable words.

---

# R example Code for Calculations

```r
library(dplyr)
library(stringr)

responses <- responses %>%
  mutate(
    response = str_to_lower(response),
    response = str_replace_all(response, "[[:punct:]]", "")
  )

freq_table <- responses %>%
  group_by(sentence_id, response) %>%
  summarise(n = n(), .groups = "drop")

totals <- responses %>%
  group_by(sentence_id) %>%
  summarise(total = n(), .groups = "drop")

cloze <- freq_table %>%
  left_join(totals, by = "sentence_id") %>%
  mutate(probability = n / total)

entropy_table <- cloze %>%
  mutate(entropy_component = probability * log(probability)) %>%
  group_by(sentence_id) %>%
  summarise(entropy = -sum(entropy_component), .groups = "drop")

cloze <- cloze %>%
  mutate(surprisal = -log(probability))
```