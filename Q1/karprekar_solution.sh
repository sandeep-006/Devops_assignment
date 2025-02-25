#!/bin/bash

# Function to sort digits in ascending or descending order
sort_digits() {
    echo "$1" | grep -o . | sort "$2" | tr -d '\n'
}

# Function to validate input
validate_input() {
    local input="$1"

    # Check if input is numeric and exactly 4 digits
    if ! [[ "$input" =~ ^[0-9]{4}$ ]]; then
        echo "❌ Invalid input! Please enter exactly a 4-digit numeric value (e.g., 1234)."
        exit 1
    fi

    # Check if all digits are the same
    if [[ $(echo "$input" | grep -o . | sort | uniq | wc -l) -eq 1 ]]; then
        echo "⚠️  All digits are identical. Karprekar’s routine won’t proceed (e.g., 1111 -> no progress)."
        exit 1
    fi
}

# Prompt user for input
read -p "Enter a 4-digit number (with at least two distinct digits): " num

# Validate user input
validate_input "$num"

echo -e "\n🔄 Starting Karprekar’s Routine:"
count=0

while [[ "$num" != "6174" ]]; do
    ((count++))
    asc=$(sort_digits "$num" "")     # Ascending order
    desc=$(sort_digits "$num" "-r")  # Descending order
    result=$((desc - asc))

    printf "Step %d: %s - %s = %04d\n" "$count" "$desc" "$asc" "$result"

    if [[ "$result" -eq 0 ]]; then
        echo "🚫 Reached 0000. No further progress possible."
        break
    fi

    num=$(printf "%04d" "$result")
done

[[ "$num" == "6174" ]] && echo -e "✅ Kaprekar’s constant 6174 reached in $count steps!"
