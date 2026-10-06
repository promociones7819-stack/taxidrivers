# Taxi English · lector interactivo

Prototipo de estudio en español para el workbook **Taxi Drivers**.

## Abrir la versión publicada

[https://taxidrivers.promociones7819.workers.dev](https://taxidrivers.promociones7819.workers.dev)

El lector muestra las 120 páginas como imágenes derivadas del PDF original. El OCR con coordenadas está activo para las páginas 7–14 (unidades 1–4): consulta palabras, selecciona frases en el panel de apoyo, escucha pronunciación y guarda vocabulario.

## Código

- `public/index.html`, `public/styles.css`, `public/app.js`: interfaz y lector.
- `worker.js`, `wrangler.jsonc`: Cloudflare Worker y archivos estáticos.
- `scripts/prepare-assets.sh`, `scripts/vision-ocr.swift`: preparar las imágenes de las 120 páginas y generar el OCR inicial en macOS.

## Regenerar activos y desplegar

Los archivos del libro (PDF fuente, imágenes derivadas y JSON OCR) no forman parte del historial de Git. Para recrearlos, instala Poppler en macOS, coloca el PDF en `assets/taxi-drivers.pdf` y ejecuta:

```sh
scripts/prepare-assets.sh
npx wrangler deploy --config wrangler.jsonc
```

El script crea imágenes web optimizadas para las 120 páginas y OCR para las páginas 7–14. Añade nuevas páginas OCR al JSON con las mismas coordenadas normalizadas para ampliar la capa interactiva.