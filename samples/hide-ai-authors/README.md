# AI Author Hiding Configuration

This directory contains configuration files for hiding AI authors in Copilot.

## Files

- `.cursorignore` - Ignore patterns for AI authors
- `README.md` - This file

## Usage

To hide AI authors in Copilot:

1. Copy `.cursorignore` to your project root
2. Add the patterns to your `.git/info/exclude` or `.gitignore`

## How It Works

The ignore file contains patterns that tell Git to ignore certain files when showing blame or history, effectively hiding AI-generated content from authorship tracking.
