cat Download-FlyCellAtlas.csv | sed '1d' | awk -F ','  '{ print $1"\t"$2"\t"$5}' > batch-download.txt
# cat batch-download.txt | while read tissue library link; do mkdir -p $tissue/$library; cd $tissue/$library; curl --output $(basename $link) $link; cd ../../; done
# cat batch-download.txt | while read tissue library link; do mkdir -p $tissue/$library; cd $tissue/$library; wget $link; cd ../../; done
# cat batch-download.txt | sed '1,2d' | while read tissue library link; do mkdir -p $tissue/$library; cd $tissue/$library; aria2c -s 10 -x 10 $link; cd ../../; done