#!/bin/sh
rm -Rf /gpfs/fs1/pts/sequential-small/
rm -Rf /gpfs/fs2/pts/sequential-small/
mkdir /gpfs/fs1/pts/
mkdir /gpfs/fs1/pts/sequential-small/
mkdir /gpfs/fs2/pts/
mkdir /gpfs/fs2/pts/sequential-small/

time dd if=/dev/urandom of=/gpfs/fs1/pts/sequential-small/sequential-small.file bs=1M count=1024 > /gpfs/fs1/pts/sequential-small/sequential-small-results.txt

sha1sum /gpfs/fs1/pts/sequential-small/sequential-small.file >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt > /gpfs/fs1/pts/sequential-small/sequential-small.file.sha1
#time cp --force --verbose /gpfs/fs1/pts/sequential-small/sequential-small.file /gpfs/fs2/pts/sequential-small/sequential-small.file >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
rsync -a --info=progress2 --stats /gpfs/fs1/pts/sequential-small/sequential-small.file /gpfs/fs2/pts/sequential-small/sequential-small.file >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
rsync -a --info=progress2 --stats /gpfs/fs2/pts/sequential-small/sequential-small.file /gpfs/fs1/pts/sequential-small/sequential-small.file.sanity >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
sha1sum /gpfs/fs1/pts/sequential-small/sequential-small.file.sanity >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt > /gpfs/fs1/pts/sequential-small/sequential-small.file.sanity.sha1
echo "CMP says:" >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
cmp -b /gpfs/fs1/pts/sequential-small/sequential-small.file /gpfs/fs1/pts/sequential-small/sequential-small.file.sanity >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
echo "If it's blank, no news is good news" >> /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
cat /gpfs/fs1/pts/sequential-small/sequential-small-results.txt
