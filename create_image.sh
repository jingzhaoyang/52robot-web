source_dir="./assets/images/"
target_dir="./assets/small-images/"
target_width=368
target_height=180
scale="scale=2;"
target_ratio=$(echo "${scale}(${target_width}/${target_height})"|bc)

for i in $(cd ./${source_dir}/;ls *)
do
    source_width=$(identify ${source_dir}/${i} |awk -F ' '  '{print $3}'|awk -F 'x' '{print $1}')
    source_height=$(identify ${source_dir}/${i} |awk -F ' '  '{print $3}'|awk -F 'x' '{print $2}')
    echo ${source_width}
    source_ratio=$(echo "${scale}(${source_width}/${source_height})"|bc)
    echo $source_ratio
    if [[ ${source_ratio} > ${target_ratio} ]]; then
      convert -resize ${target_height} ${source_dir}/${i} ${target_dir}/${i}
      tmp_width=$(identify ./${target_dir}/${i} |awk -F ' '  '{print $3}'|awk -F 'x' '{print $1}')
      pos_x=$(echo "(${tmp_width}-${target_width})/2"|bc)
      convert -crop ${target_width}x${target_height}+${pos_x}+0 ${target_dir}/${i} ${target_dir}/${i}

    fi
    if [[ ${source_ratio} < ${target_ratio} ]]; then
      convert -resize ${target_width} ${source_dir}/${i} ${target_dir}/${i}
      tmp_height=$(identify ./${target_dir}/${i} |awk -F ' '  '{print $3}'|awk -F 'x' '{print $2}')
      pos_y=$(echo "(${tmp_height}-${target_height})/2"|bc)
      convert -crop ${target_width}x${target_height}+0+${pos_y} ${target_dir}/${i} ${target_dir}/${i}

      #statements
    fi
    # tmp_width=$(identify ./${target_dir}/${i} |awk -F ' '  '{print $3}'|awk -F 'x' '{print $1}')
    # tmp_height=$(identify ./${target_dir}/${i} |awk -F ' '  '{print $3}'|awk -F 'x' '{print $2}')
    # if [[ ${tmp_width} > ${target_width} ]]; then
    #   pos_x=$(echo "(${tmp_width}-${target_width})/2"|bc)
    #   convert -crop ${target_width}x${target_height}+${pos_x}+0 ${target_dir}/${i} ${target_dir}/${i}
    #   #statements
    # fi
    # if [[ ${tmp_height} > ${target_height} ]]; then
    #   pos_y=$(echo "(${tmp_height}-${target_height})/2"|bc)
    #   convert -crop ${target_width}x${target_height}+0+${pos_y} ${target_dir}/${i} ${target_dir}/${i}
    #   # statements
    # fi
    # composite -gravity southeast -geometry 42x42+290+8  ./weixin-new.png ./${target_dir}/$i ./${target_dir}/$i
    mogrify -font /home/jing/.local/share/fonts/Adobe-Heiti-Std-R.TTF -pointsize 24 -fill white\
     -weight bolder -gravity southeast -annotate +1-15 @"logo.txt" ./${target_dir}/${i} ./${target_dir}/${i}
done
