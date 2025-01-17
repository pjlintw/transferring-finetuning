#!/bin/bash


# # Set the directory to save downloaded models
SAVE_DIR="/PATH/"

# Define the list of models to download
MODELS=(
    # "allenai/OLMo-7B-0724-Instruct-hf"
    # "allenai/OLMo-7B-0724-hf"
    # "allenai/OLMo-1B-0724-hf"
    # "meta-llama/Meta-Llama-3-8B"
    # "meta-llama/Meta-Llama-3-8B-Instruct"
    # "meta-llama/Llama-3.1-8B"
    # "meta-llama/Llama-3.1-8B-Instruct"
    # "meta-llama/Llama-3.2-1B"
    # "meta-llama/Llama-3.2-1B-Instruct"
    # "meta-llama/Llama-3.2-3B"
    # "meta-llama/Llama-3.2-3B-Instruct"
    # "meta-llama/Meta-Llama-Guard-2-8B"
    # "meta-llama/Llama-Guard-3-8B"
    # "allenai/Llama-3.1-Tulu-3-8B"
    # "allenai/Llama-3.1-Tulu-3-8B-SFT"
    # "allenai/Llama-3.1-Tulu-3-8B-DPO"

    # "allenai/OLMo-2-1124-7B"
    # "allenai/OLMo-2-1124-7B-sft"
    # "allenai/OLMo-2-1124-7B-dpo"
    # "allenai/OLMo-2-1124-7B-instruct"
    # "allenai/OLMo-2-1124-7B"

    # "allenai/OLMo-2-1124-13B"    
    # "allenai/OLMo-2-1124-13B-Instruct"

    "allenai/OLMo-7B-0724-hf"
)

# Define the list of revisions to match each model (main revision for all models)
REVISIONS=(
    "stage2-ingredient1-step11931-tokens50B"
    "stage2-ingredient1-step6000-tokens26B"
    
    "stage1-step928646-tokens3896B"
    "stage1-step600000-tokens2517B"
    "stage1-step300000-tokens1259B"
)


# Loop over each model and revision
for model in "${MODELS[@]}"
do
    for revision in "${REVISIONS[@]}"
    do
        # Convert the model name to lowercase and set it as the folder name
        model_name_lower=$(echo "${model##*/}" | tr '[:upper:]' '[:lower:]')
        revision_lower=$(echo "$revision" | tr '[:upper:]' '[:lower:]')
        OUTPUT_DIR="${SAVE_DIR}/${model_name_lower}-${revision_lower}"

        echo "Downloading model: $model"
        echo "Revision: $revision"
        echo "Saving model to: $OUTPUT_DIR"

        # Run the Python script to download and save the model and tokenizer with the specified revision
        python save_model_class.py \
            --model_name_and_path="$model" \
            --tokenizer="$model" \
            --output_dir="$OUTPUT_DIR" \
            --revision="$revision"
        
        # Check if the command was successful
        if [ $? -eq 0 ]; then
            echo "Model $model (revision $revision) downloaded and saved successfully"
        else
            echo "Failed to download model $model (revision $revision)" >&2
            exit 1
        fi
    done
done


