#!/bin/bash

awk '
BEGIN {
    FS = "\\|";  # Set field separator to pipe character
    max_duration = 0;
    security_code = "";
}

# Skip comment lines and empty lines
/^#/ || /^$/ { next }

# Process only completed Mars missions
$4 ~ /Completed/ && $3 ~ /Mars/ {
    # Remove any whitespace from duration field
    gsub(/[[:space:]]/, "", $6);
    duration = $6 + 0;  # Convert to number
    
    if (duration > max_duration) {
        max_duration = duration;
        # Remove any whitespace from security code
        gsub(/[[:space:]]/, "", $8);
        security_code = $8;
    }
}

END {
    print security_code;
}' space_missions.log 