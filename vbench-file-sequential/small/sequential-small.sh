#!/bin/sh
rm -Rf /gpfs/cache/pts/sequential-small/
rm -Rf /gpfs/data/pts/sequential-small/
mkdir /gpfs/cache/pts/
mkdir /gpfs/cache/pts/sequential-small/
mkdir /gpfs/data/pts/
mkdir /gpfs/data/pts/sequential-small/

time dd if=/dev/urandom of=/gpfs/cache/pts/sequential-small/sequential-small.file bs=1M count=1024 > /gpfs/cache/pts/sequential-small/sequential-small-results.txt

sha1sum /gpfs/cache/pts/sequential-small/sequential-small.file >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt > /gpfs/cache/pts/sequential-small/sequential-small.file.sha1
#time cp --force --verbose /gpfs/data/pts/sequential-small/sequential-small.file /gpfs/data/pts/sequential-small/sequential-small.file >> /gpfs/data/pts/sequential-small/sequential-small-results.txt
rsync -a --info=progress2 --stats /gpfs/cache/pts/sequential-small/sequential-small.file /gpfs/data/pts/sequential-small/sequential-small.file >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt
rsync -a --info=progress2 --stats /gpfs/data/pts/sequential-small/sequential-small.file /gpfs/cache/pts/sequential-small/sequential-small.file.sanity >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt
sha1sum /gpfs/cache/pts/sequential-small/sequential-small.file.sanity >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt > /gpfs/cache/pts/sequential-small/sequential-small.file.sanity.sha1
echo "CMP says:" >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt
cmp -b /gpfs/cache/pts/sequential-small/sequential-small.file /gpfs/cache/pts/sequential-small/sequential-small.file.sanity >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt
echo "If it's blank, no news is good news" >> /gpfs/cache/pts/sequential-small/sequential-small-results.txt
cat /gpfs/cache/pts/sequential-small/sequential-small-results.txt
