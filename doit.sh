#!/bin/bash
# Author: Jonathan Sprinkle (with code from Matt Bunting and Matt Nice from libpanda)

#if [ ! -d ${FOLDER_PRE}/${FOLDER_DATE} ]; then
#	echo "Creating ${FOLDER_PRE}/${FOLDER_DATE}..."
#	mkdir -p ${FOLDER_PRE}/${FOLDER_DATE}
#fi
#pandacord -g ${FOLDER}/${FILENAME_PRE}_GPS_Messages.csv -c ${FOLDER}/${FILENAME_PRE}_CAN_Messages.csv

# Name of the required conda environment
REQUIRED_ENV="ouster"

# Initialize conda in the current shell
__conda_setup="$('conda' 'shell.bash' 'hook' 2>/dev/null)"
if [[ $? -ne 0 ]]; then
    echo "Error: Conda not found or not properly configured."
    exit 1
fi
eval "$__conda_setup"

# Check if the correct environment is active
if [[ "$CONDA_DEFAULT_ENV" != "$REQUIRED_ENV" ]]; then
    echo "Conda environment '$REQUIRED_ENV' is not active. Attempting to activate it..."

    # Check if the environment exists
    if conda info --envs | awk '{print $1}' | grep -q "^$REQUIRED_ENV$"; then
        conda activate "$REQUIRED_ENV"
        if [[ "$CONDA_DEFAULT_ENV" != "$REQUIRED_ENV" ]]; then
            echo "Error: Failed to activate Conda environment '$REQUIRED_ENV'."
	    echo "Please run the initial_setup.sh to install the prerequisites."
            exit 1
        fi
        echo "Successfully activated '$REQUIRED_ENV'."
    else
        echo "Error: Conda environment '$REQUIRED_ENV' does not exist."
        echo "Please run the initial_setup.sh to install the prerequisites."
        exit 1
    fi
fi

# Environment is active, continue with the rest of the script
echo "Environment '$REQUIRED_ENV' is active. Proceeding..."


FOLDER_PRE="."
FOLDER_DATE=$(date +%Y_%m_%d)
FOLDER=${FOLDER_PRE}/${FOLDER_DATE}
FILENAME=$(date +%Y-%m-%d-%H-%M-%S-lidar_stream.osf)

PATH_TO_SAVE=${FOLDER}/${FILENAME}

if [ ! -d ${FOLDER_PRE}/${FOLDER_DATE} ]; then
	echo "Creating ${FOLDER_PRE}/${FOLDER_DATE}..."
	mkdir -p ${FOLDER_PRE}/${FOLDER_DATE}
fi

echo "Preparing to save to file ${PATH_TO_SAVE}"

# Infinite loop--snagged from chatgpt
# Handle Ctrl+C (SIGINT)
trap "echo 'Closing file ${PATH_TO_SAVE} and shutting down...'; exit 0" SIGINT

while true; do
	echo "ouster-cli source 192.168.0.101 save ${PATH_TO_SAVE}"
done