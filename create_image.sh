source_dir="./assets/images/"
target_dir="./assets/small-images/"
for i in $(cd ./${source_dir}/;ls *)
do
    convert -resize 373x183\! ./${source_dir}/$i ./${target_dir}/$i
    # composite -gravity southeast -geometry 42x42+290+8  ./weixin-new.png ./${target_dir}/$i ./${target_dir}/$i
    mogrify -font /home/jing/.local/share/fonts/Adobe-Heiti-Std-R.TTF -pointsize 24 -fill white\
     -weight bolder -gravity southeast -annotate +1-15 @"logo.txt" ./${target_dir}/$i ./${target_dir}/$i
done
