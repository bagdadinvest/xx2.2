# Input file
$input_file = "highway-loop.mp4"
$output_prefix = "output"

# Get the duration of the video in seconds
$duration = (& ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $input_file).Trim()
Write-Output "Total duration: $duration seconds"

# Calculate the duration of each segment (1/4th of the total duration)
$segment_duration = [math]::Round($duration / 4)
Write-Output "Segment duration: $segment_duration seconds"

# Split the video into 4 parts
& ffmpeg -i $input_file -c copy -map 0 -segment_time $segment_duration -f segment "${output_prefix}%03d.mp4"
