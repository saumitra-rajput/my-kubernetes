#!/bin/bash

for i in $(seq -w 1 26)
do
    dir="day-$i"
    mkdir -p "$dir"

    cat > "$dir/README.md" <<EOF
# Day $i :shipit:

## Task

## Commands Used

## What I Learned

## Notes
EOF

done

echo "Directories day-01 to day-26 created successfully."
