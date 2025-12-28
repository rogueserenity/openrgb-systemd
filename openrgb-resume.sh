#!/bin/bash
# OpenRGB resume script for systemd sleep hook

OPENRGB_CMD="/usr/bin/openrgb"

# Function to set OpenRGB color
# Usage: set_openrgb_color <color> <context>
# Example: set_openrgb_color "000000" "suspend"
set_openrgb_color() {
  local color="$1"
  local context="$2"
  
  # Check if OpenRGB executable exists
  if [ ! -f "$OPENRGB_CMD" ]; then
    logger -t openrgb-resume -p err "OpenRGB not found at $OPENRGB_CMD"
    return 1
  fi
  
  # Set the color
  output=$("$OPENRGB_CMD" --mode direct --color "$color" 2>&1)
  exit_code=$?
  logger -t openrgb-resume "OpenRGB $context output: $output"
  logger -t openrgb-resume "OpenRGB $context exit code: $exit_code"
  
  if [ $exit_code -ne 0 ]; then
    logger -t openrgb-resume -p err "Failed to set OpenRGB color on $context"
    return 1
  fi
  
  logger -t openrgb-resume "OpenRGB color set successfully for $context"
  return 0
}

case "$1/$2" in
  pre/*)
    # System is going to sleep - turn off all lights
    logger -t openrgb-resume "OpenRGB suspend script triggered: $1/$2 - turning off lights"
    set_openrgb_color "000000" "suspend" || exit 1
    ;;
  post/*)
    # System is resuming from sleep
    logger -t openrgb-resume "OpenRGB resume script triggered: $1/$2 - restoring lights"
    
    # Wait a short delay to ensure hardware is ready
    sleep 2
    
    set_openrgb_color "640064" "resume" || exit 1
    ;;
  *)
    # Unknown event - do nothing
    exit 0
    ;;
esac

exit 0
