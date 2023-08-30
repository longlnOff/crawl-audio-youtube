from pytube import YouTube
from pytube import Playlist
from tqdm import tqdm
import moviepy.editor as mp
import os
from pydub import AudioSegment


with open('list_playlist_youtube.txt', 'r') as file_txt:
	files = file_txt.readlines()
# check for destination to save file
destination = 'data_youtube/mp3_files/'

for playlist_location in files:
	playlist_obj = Playlist(playlist_location)
	pbar = tqdm(playlist_obj.videos)
	print('Download file and convert to mp3 format')
	for count, video in enumerate(pbar): 
		r = video.streams.filter(only_audio=True).first()
		out_file = r.download(output_path=destination)
		base, ext = os.path.splitext(out_file)
		base = base.replace(' ', '_')
		# new_file = destination + '/' + str(count) + '.mp3'
		new_file = base + '.mp3'
		os.rename(out_file, new_file)
		# pbar.set_postfix_str("complete: {}".format(count))

# Convert mp3 to wav with bash script
cmd = 'bash convert_mp3_to_wav.sh'
os.system(cmd)