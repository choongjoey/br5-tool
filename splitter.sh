#!/bin/bash
echo "Trying to split into br5 files"

part=1
prev=0
for offset in $(bgrep 'CFD94D8A719930EE5926FF55FF9D3193' musicdata)
do
    offset=$((16#${offset%%*:}))
    if [ ${offset} = 0 ]; then continue; fi
    total=$(((${offset} - ${prev})))
    echo dd from ${prev} to ${offset} into song_${part}
    dd if=musicdata of=song_${part}.br5 bs=1 skip=${prev} count=${total}
    python flipper.py song_${part}.br5
    prev=${offset}
    let part+=1
done
echo dd from ${prev} to end into song_${part}
dd if=musicdata of=song_${part}.br5 bs=1 skip=${prev}
python flipper.py song_${part}.br5
