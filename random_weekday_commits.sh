#!/bin/bash

START_DATE="2024-01-01"
END_DATE="2024-02-28"

current_date="$START_DATE"

while [[ "$current_date" < "$END_DATE" ]]; do
    day_of_week=$(date -d "$current_date" +%u)  # 1=Mon, ..., 7=Sun

    # Only process Monday–Friday (1–5)
    if [[ $day_of_week -le 5 ]]; then
        # 50% chance to make commits on this day
        if (( RANDOM % 2 == 0 )); then
            num_commits=$((RANDOM % 3 + 1))  # 1 to 3 commits

            for ((i = 1; i <= num_commits; i++)); do
                export GIT_AUTHOR_DATE="$current_date 0$((RANDOM % 9 + 8)):$((RANDOM % 60)):00"
                export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
                echo "$current_date - Commit $i" >> history.txt
                git add history.txt
                git commit -m "Commit $i on $current_date"
            done
        fi
    fi

    current_date=$(date -I -d "$current_date + 1 day")
done
