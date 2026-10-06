# Taxi Drivers · lector de inglés

Lector de estudio en español para el workbook Taxi Drivers. Conserva las páginas originales como imágenes y añade encima una capa OCR con coordenadas para consultar palabras, escuchar pronunciación y guardar vocabulario.

## Desarrollo

- Interfaz: `public/index.html`, `public/styles.css`, `public/app.js`.
- Worker y publicación de archivos estáticos: `worker.js`, `wrangler.jsonc`.
- Generación de páginas del libro y OCR inicial: `scripts/prepare-assets.sh`.
- Páginas OCR habilitadas: 7–14 del PDF (unidades 1–4).
- Las páginas 1–120 se sirven como imágenes originales. Para generar los archivos localmente, coloca el PDF fuente en `assets/taxi-drivers.pdf` y ejecuta `scripts/prepare-assets.sh` en macOS con Poppler instalado.

El PDF y los archivos de páginas generados no se guardan en Git. El Worker publicado sirve las imágenes originales generadas desde el archivo fuente proporcionado para este proyecto.

## Publicación

Instala Wrangler y autentícate con Cloudflare. Después ejecuta:

```sh
npx wrangler deploy --config wrangler.jsonc
```

La configuración actual publica el Worker `taxidrivers` en Cloudflare Workers.