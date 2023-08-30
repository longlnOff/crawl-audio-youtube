
#!/bin/bash

# Specify the folder path
source_dir="data_youtube"
mp3_files_dir="$source_dir"/mp3_files
destination_dir="$source_dir"/wav_files
mkdir -p "$destination_dir"

mp3_files=($(find "$mp3_files_dir" -type f -name "*.mp3"))
number_of_files=$(ls "$mp3_files_dir"/*.mp3 | wc -l)
# Loop through each MP3 file in the folder
# Iterate through the found FLAC files and convert them to WAV
echo 'convert mp3 to wav'
for mp3_file in "${mp3_files[@]}"; do
    # echo "$mp3_file"
    # Get the relative path of the FLAC file
    rel_path="${mp3_file#$mp3_files_dir}"
    # Replace the ".flac" extension with ".wav"
    wav_file="${rel_path%.mp3}.wav"
    # Construct the destination path
    dest_path="$destination_dir$wav_file"

    # Create the destination directory if it doesn't exist
    mkdir -p "$(dirname "$dest_path")"

    # Convert FLAC to WAV
    echo "Converting..." # $mp3_file to $dest_path..."
    ffmpeg -hide_banner -loglevel panic -i "$mp3_file" -acodec pcm_u8 -ar 16000 "$dest_path"
done | tqdm --total $number_of_files >>/dev/null
