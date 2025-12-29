#!/usr/bin/env bash

# Get list of all active workspaces (those with windows)
active_workspaces=$(hyprctl workspaces -j | jq -r '.[] | select(.windows > 0) | .id' | sort -n)

# Get current workspace
current=$(hyprctl activeworkspace -j | jq -r '.id')

# Determine direction
direction="${1:-forward}"

# Convert to arrays
mapfile -t ws_array <<< "$active_workspaces"

if [[ ${#ws_array[@]} -eq 0 ]]; then
    exit 1
fi

# Find current index
current_index=-1
for i in "${!ws_array[@]}"; do
    if [[ "${ws_array[$i]}" == "$current" ]]; then
        current_index=$i
        break
    fi
done

# If current workspace not in active list, go to first
if [[ $current_index -eq -1 ]]; then
    hyprctl dispatch workspace "${ws_array[0]}"
    exit 0
fi

# Calculate next index
if [[ "$direction" == "forward" ]]; then
    next_index=$(( (current_index + 1) % ${#ws_array[@]} ))
else
    next_index=$(( (current_index - 1 + ${#ws_array[@]}) % ${#ws_array[@]} ))
fi

# Switch to next workspace
hyprctl dispatch workspace "${ws_array[$next_index]}"
