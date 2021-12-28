#!/bin/sh
rm -Rf /gpfs/cache/pts/sequential-large/
rm -Rf /gpfs/data/pts/sequential-large/
mkdir /gpfs/cache/pts/
mkdir /gpfs/cache/pts/sequential-large/
mkdir /gpfs/data/pts/
mkdir /gpfs/data/pts/sequential-large/

time dd if=/dev/urandom of=/gpfs/cache/pts/sequential-large/sequential-intermediate.file bs=1M count=1024 > /gpfs/cache/pts/sequential-large/sequential-large-results.txt

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
   cat /gpfs/cache/pts/sequential-large/sequential-intermediate.file >> /gpfs/cache/pts/sequential-large/sequential-large.file
done

sha1sum /gpfs/cache/pts/sequential-large/sequential-large.file >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt > /gpfs/cache/pts/sequential-large/sequential-large.file.sha1
#time cp --force --verbose /gpfs/data/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file1 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file1 /gpfs/cache/pts/sequential-large/sequential-large.file2 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file2 /gpfs/data/pts/sequential-large/sequential-large.file3 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file13 /gpfs/cache/pts/sequential-large/sequential-large.file4 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file4 /gpfs/data/pts/sequential-large/sequential-large.file5 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file15 /gpfs/cache/pts/sequential-large/sequential-large.file6 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file6 /gpfs/data/pts/sequential-large/sequential-large.file7 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file17 /gpfs/cache/pts/sequential-large/sequential-large.file8 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-large/sequential-large.file8 /gpfs/data/pts/sequential-large/sequential-large.file9 >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file19 /gpfs/cache/pts/sequential-large/sequential-large.file.sanity >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
sha1sum /gpfs/cache/pts/sequential-large/sequential-large.file.sanity >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt > /gpfs/cache/pts/sequential-large/sequential-large.file.sanity.sha1
echo "CMP says:" >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
cmp -b /gpfs/cache/pts/sequential-large/sequential-large.file /gpfs/cache/pts/sequential-large/sequential-large.file.sanity >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
echo "If it's blank, no news is good news" >> /gpfs/cache/pts/sequential-large/sequential-large-results.txt
cat /gpfs/cache/pts/sequential-large/sequential-large-results.txt
