#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PDF="${1:-$ROOT/assets/taxi-drivers.pdf}"
OUT="$ROOT/public/assets"
WORK="$ROOT/work/ocr-render"

if [[ ! -f "$PDF" ]]; then
  echo "No encuentro el PDF fuente: $PDF" >&2
  echo "Coloca Taxi drivers.pdf en assets/taxi-drivers.pdf o pásalo como argumento." >&2
  exit 1
fi
if ! command -v pdftoppm >/dev/null 2>&1; then
  echo "Falta pdftoppm (Poppler). Instálalo con: brew install poppler" >&2
  exit 1
fi

mkdir -p "$OUT/pages" "$WORK"
pdftoppm -f 1 -l 120 -jpeg -r 130 -jpegopt quality=86 "$PDF" "$OUT/pages/page"
pdftoppm -f 7 -l 14 -jpeg -r 180 -jpegopt quality=90 "$PDF" "$WORK/ocr"
swift "$ROOT/scripts/vision-ocr.swift" "$WORK"/ocr-*.jpg "$OUT/ocr-pages.json"

echo "120 páginas generadas y OCR preparado para las páginas 7–14."
