## Goal of the code in this folder.

A file ``../d00_scores_freq_words.dart`` 🎯   

## How it's work

1. Find a source of "most frequent words" and replace ``./tmp00_word_freqiency.txt`` file.
   - Good source: https://norvig.com/ngrams
   - Example: ``curl -o ./tmp00_word_freqiency.txt https://norvig.com/ngrams/count_1w.txt``

1. Correct and run ``./s00_read_file.dart``. Check lines with emoji 👀 in a comment. 
   - Example: ``dart run ./s00_read_file.dart``
   - Check result in ``./tmp01_len_five_word_s.dart``

1. Run ``./s01_scoring.dart``. Check result in ``./tmp02_score_len_five_word.dart``

1. Run ``./s02_scored_unique.dart``. Check result in ``./tmp03_unique_five_filter.dart``

1. Run ``./s03_create_data_file.dart``. Check result in ``../d00_scores_freq_words.dart`` 🎯

1. Run ``git restore tmp*`` To restore tmp files in to a sample state.