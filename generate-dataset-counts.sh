#!/bin/bash

DATASETS_PATH="datasets"
OUTPUT_FILE="$DATASETS_PATH/dataset-counts.json"

MAX_COUNT=0
PARKS_JSON=""

# Loop through each local authority
for LA in Bradford Calderdale Kirklees Leeds Wakefield; do
    LA_PATH="$DATASETS_PATH/$LA"
    
    if [ ! -d "$LA_PATH" ]; then
        echo "Warning: $LA_PATH does not exist"
        continue
    fi
    
    # Loop through each park folder
    for PARK_FOLDER in "$LA_PATH"/*; do
        if [ ! -d "$PARK_FOLDER" ]; then
            continue
        fi
        
        PARK_NAME=$(basename "$PARK_FOLDER")
        GEOJSON_COUNT=$(find "$PARK_FOLDER" -maxdepth 1 -name "*.geojson" | wc -l)
        
        if [ "$GEOJSON_COUNT" -gt 0 ]; then
            # Update max count
            if [ "$GEOJSON_COUNT" -gt "$MAX_COUNT" ]; then
                MAX_COUNT=$GEOJSON_COUNT
            fi
            
            # Add to JSON string with comma separator
            if [ -z "$PARKS_JSON" ]; then
                PARKS_JSON="    \"$PARK_NAME\": $GEOJSON_COUNT"
            else
                PARKS_JSON="$PARKS_JSON,\n    \"$PARK_NAME\": $GEOJSON_COUNT"
            fi
        fi
    done
done

# Write complete JSON with proper formatting
cat > "$OUTPUT_FILE" << EOF
{
  "maxCount": $MAX_COUNT,
  "parks": {
$(echo -e "$PARKS_JSON")
  }
}
EOF

PARK_COUNT=$(grep -c '": ' "$OUTPUT_FILE")

echo "✓ Generated $OUTPUT_FILE"
echo "  Max datasets: $MAX_COUNT"
echo "  Total parks: $PARK_COUNT"
