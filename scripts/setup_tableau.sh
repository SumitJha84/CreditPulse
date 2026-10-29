#!/usr/bin/env bash
# Prepare ChurnIQ Tableau workbook for publishing (Linux-safe prep step)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "=== ChurnIQ Tableau setup ==="
echo "Project root: $ROOT"
echo

# Ensure data copy exists
mkdir -p data
if [[ ! -f data/train.csv ]]; then
  cp "Machine learning Models/Neural_Networks/train.csv" data/train.csv
  echo "✓ Copied train.csv → data/train.csv"
else
  echo "✓ data/train.csv already exists"
fi

# Regenerate workbook with current absolute paths.
# The published Tableau Public workbook identifier remains the live dashboard slug unless a matching ChurnIQ workbook has been published.
TRAIN="$ROOT/data/train.csv"
TRAIN_DIR="$ROOT/data"
sed -e 's|BankChurnVisualisation|ChurnIQChurnVisualisation|g' \
    -e "s|/Users/talieh/Studies/Monash_Bootcamp/Assignments/Project_4/Bank_Churn_Project/train.csv|${TRAIN}|g" \
    -e "s|/Users/talieh/Studies/Monash_Bootcamp/Assignments/Project_4/Bank_Churn_Project|${TRAIN_DIR}|g" \
    "Bank Churn Visualisation.twb" > "ChurnIQ Churn Visualisation.twb"

echo "✓ Created ChurnIQ Churn Visualisation.twb"
echo
echo "Tableau Public is NOT available on Linux."
echo "Next: publish on Windows/Mac — see scripts/publish_tableau.md"
echo
echo "After publishing, verify the live workbook URL and update templates/visualization.html if the published workbook name changes:"
echo "  https://public.tableau.com/views/AnshivyaChurnVisualisation/Dashboard1"
echo
echo "Then run Flask and open:"
echo "  http://localhost:9092/visualization"
