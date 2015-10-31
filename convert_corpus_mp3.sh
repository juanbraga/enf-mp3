#bin/bash          
echo Start conversion: corpus ahumada
dir="./corpus_ahumada"
for file in ./corpus_ahumada/*
do
out="$(echo $file | cut -d'.' -f 2 )" 
out=".$out.mp3"
lame --preset 128 $file $out
done

echo Start conversion: corpus carioca
dir="./corpus_carioca"
for file in ./corpus_carioca/*
do
out="$(echo $file | cut -d'.' -f 2 )"
out=".$out.mp3"
lame --preset 128 $file $out
done
      
