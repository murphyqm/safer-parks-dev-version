#!/bin/bash

# Find and list all files in the current directory (recursively)
# that are 100 MB (100M) or larger.

find . -type f -size +100M -print
