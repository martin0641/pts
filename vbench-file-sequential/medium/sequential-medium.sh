#!/bin/sh
rm -Rf /gpfs/cache/pts/sequential-medium/
rm -Rf /gpfs/data/pts/sequential-medium/
mkdir /gpfs/cache/pts/
mkdir /gpfs/cache/pts/sequential-medium/
mkdir /gpfs/data/pts/
mkdir /gpfs/data/pts/sequential-medium/

time dd if=/dev/urandom of=/gpfs/cache/pts/sequential-medium/sequential-intermediate.file bs=1M count=1024 > /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt

for i in 1 2 3 4 5
do
   cat /gpfs/cache/pts/sequential-medium/sequential-intermediate.file >> /gpfs/cache/pts/sequential-medium/sequential-medium.file
done

sha1sum /gpfs/cache/pts/sequential-medium/sequential-medium.file >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt > /gpfs/cache/pts/sequential-medium/sequential-medium.file.sha1
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-medium/sequential-medium.file /gpfs/data/pts/sequential-medium/sequential-medium.file >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-medium/sequential-medium.file /gpfs/cache/pts/sequential-medium/sequential-medium.file.sanity >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt
sha1sum /gpfs/cache/pts/sequential-medium/sequential-medium.file.sanity >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt > /gpfs/cache/pts/sequential-medium/sequential-medium.file.sanity.sha1
echo "CMP says:" >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt
cmp -b /gpfs/cache/pts/sequential-medium/sequential-medium.file /gpfs/cache/pts/sequential-medium/sequential-medium.file.sanity >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt
echo "If it's blank, no news is good news" >> /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt
cat /gpfs/cache/pts/sequential-medium/sequential-medium-results.txt
echo "5GB Transfer Test Complete" 