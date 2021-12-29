#!/bin/sh

rm -Rf /gpfs/cache/pts/sequential-large/
rm -Rf /gpfs/data/pts/sequential-large/
mkdir /gpfs/cache/pts/
mkdir /gpfs/cache/pts/sequential-large/
mkdir /gpfs/data/pts/
mkdir /gpfs/data/pts/sequential-large/

time dd if=/dev/urandom of=/gpfs/cache/pts/sequential-large/sequential-intermediate.file bs=1K count=1024 > /gpfs/cache/pts/sequential-large/sequential-large-results.txt

for i in 1 2 3 4 5 6 7 8 9 10
do
   cat /gpfs/cache/pts/sequential-large/sequential-intermediate.file >> /gpfs/cache/pts/sequential-large/sequential-large.file
done

rm -f /gpfs/cache/pts/sequential-large/sequential-intermediate.file

sha1sum /gpfs/cache/pts/sequential-large/sequential-large.file >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt > /gpfs/cache/pts/sequential-large/sequential-large.file.sha1

rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file1 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file1 /gpfs/cache/pts/sequential-large/sequential-large.file2 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file1
echo "Round-01 Complete"
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file2 /gpfs/data/pts/sequential-large/sequential-large.file3 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file2
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file3 /gpfs/cache/pts/sequential-large/sequential-large.file4 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file3
echo "Round-02 Complete"
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file4 /gpfs/data/pts/sequential-large/sequential-large.file5 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file4
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file5 /gpfs/cache/pts/sequential-large/sequential-large.file6 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file5
echo "Round-03 Complete"
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file6 /gpfs/data/pts/sequential-large/sequential-large.file7 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file6
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file7 /gpfs/cache/pts/sequential-large/sequential-large.file8 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file7
echo "Round-04 Complete"
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file8 /gpfs/data/pts/sequential-large/sequential-large.file9 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rm -f /gpfs/data/pts/sequential-large/sequential-large.file8
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file9 /gpfs/cache/pts/sequential-large/sequential-large.file.sanity >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
echo "Round-05 Complete"

sha1sum /gpfs/cache/pts/sequential-large/sequential-large.file.sanity >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt > /gpfs/cache/pts/sequential-large/sequential-large.file.sanity.sha1
echo "CMP says:" >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt

cmp -b /gpfs/cache/pts/sequential-large/sequential-large.file /gpfs/cache/pts/sequential-large/sequential-large.file.sanity >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
echo "If it's blank, no news is good news" >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt

cat /gpfs/cache/pts/sequential-large/sequential-large-results.txt
echo "200GB Transfer Test Complete" 