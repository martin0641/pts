#!/bin/sh
rm -Rf /gpfs/data/pts/sequential-large/
rm -Rf /gpfs/data/pts/sequential-large/
mkdir /gpfs/data/pts/
mkdir /gpfs/data/pts/sequential-large/
mkdir /gpfs/data/pts/
mkdir /gpfs/data/pts/sequential-large/

time dd if=/dev/urandom of=/gpfs/data/pts/sequential-large/sequential-intermediate.file bs=1M count=1024 > /gpfs/data/pts/sequential-large/sequential-large-results.txt

for i in 1 2 3 4 5
do
   cat /gpfs/data/pts/sequential-large/sequential-intermediate.file >> /gpfs/data/pts/sequential-large/sequential-large.file
done

sha1sum /gpfs/data/pts/sequential-large/sequential-large.file >> /gpfs/data/pts/sequential-large/sequential-large-results.txt > /gpfs/data/pts/sequential-large/sequential-large.file.sha1
#time cp --force --verbose /gpfs/data/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file.sanity >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
sha1sum /gpfs/data/pts/sequential-large/sequential-large.file.sanity >> /gpfs/data/pts/sequential-large/sequential-large-results.txt > /gpfs/data/pts/sequential-large/sequential-large.file.sanity.sha1
echo "CMP says:" >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
cmp -b /gpfs/data/pts/sequential-large/sequential-large.file /gpfs/data/pts/sequential-large/sequential-large.file.sanity >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
echo "If it's blank, no news is good news" >> /gpfs/data/pts/sequential-large/sequential-large-results.txt
cat /gpfs/data/pts/sequential-large/sequential-large-results.txt
