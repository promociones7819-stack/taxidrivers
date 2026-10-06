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
python3 - "$OUT" <<'PY'
import json, pathlib, sys
assets = pathlib.Path(sys.argv[1])
records = json.loads((assets / "ocr-pages.json").read_text())
parts = assets / "ocr-pages"
parts.mkdir(exist_ok=True)
manifest = []
for record in records:
    name = f"{record['page']:03}.json"
    (parts / name).write_text(json.dumps(record, separators=(",", ":")))
    manifest.append(f"./assets/ocr-pages/{name}")
(assets / "ocr-manifest.json").write_text(json.dumps(manifest, separators=(",", ":")))
PY

echo "120 páginas generadas y OCR preparado para las páginas 7–14."
