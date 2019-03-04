#!/usr/bin/env bash

MAIN_PATH=$PWD
TOOLS_PATH=$PWD/tools


MOSES=$TOOLS_PATH/mosesdecoder
REPLACE_UNICODE_PUNCT=$MOSES/scripts/tokenizer/replace-unicode-punctuation.perl
NORM_PUNC=$MOSES/scripts/tokenizer/normalize-punctuation.perl
REM_NON_PRINT_CHAR=$MOSES/scripts/tokenizer/remove-non-printing-char.perl
TOKENIZER=$MOSES/scripts/tokenizer/tokenizer.perl
INPUT_FROM_SGM=$MOSES/scripts/ems/support/input-from-sgm.perl
LOWER_REMOVE_ACCENT=$TOOLS_PATH/lowercase_and_remove_accent.py

# fastBPE
FASTBPE_DIR=$TOOLS_PATH/fastBPE
FASTBPE=$TOOLS_PATH/fastBPE/fast

CODES_PATH=./data/codes_xnli_15
VOCAB_PATH=./data/vocab_xnli_15



for FILENAME in ./data/en*.txt; do
    OUTPUT_TOK="${FILENAME::-3}tok";
    PROCESSED_PATH="${FILENAME::-3}pr";
    SRC_PREPROCESSING="$REPLACE_UNICODE_PUNCT | $NORM_PUNC -l en | $REM_NON_PRINT_CHAR |                                            $TOKENIZER -l en -no-escape -threads 30 | python $LOWER_REMOVE_ACCENT"
    eval "cat $FILENAME | $SRC_PREPROCESSING > $OUTPUT_TOK";
    $FASTBPE applybpe $PROCESSED_PATH $OUTPUT_TOK $CODES_PATH;
    python preprocess.py $VOCAB_PATH $PROCESSED_PATH;
done;



for FILENAME in ./data/es*.txt; do
    OUTPUT_TOK="${FILENAME::-3}tok";
    PROCESSED_PATH="${FILENAME::-3}pr";
    SRC_PREPROCESSING="$REPLACE_UNICODE_PUNCT | $NORM_PUNC -l es | $REM_NON_PRINT_CHAR |                                            $TOKENIZER -l es -no-escape -threads 30 | python $LOWER_REMOVE_ACCENT"
    eval "cat $FILENAME | $SRC_PREPROCESSING > $OUTPUT_TOK";
    $FASTBPE applybpe $PROCESSED_PATH $OUTPUT_TOK $CODES_PATH;
    python preprocess.py $VOCAB_PATH $PROCESSED_PATH;
done;
