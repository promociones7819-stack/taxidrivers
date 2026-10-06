# Taxi English · lector interactivo

Prototipo local para estudiar con el workbook original **Taxi Drivers**.

## Abrir el lector

Abre `iniciar.command` y, cuando el navegador se abra, espera a que cargue la página. La primera carga necesita conexión a internet para descargar la fuente de la interfaz. Las páginas del libro se sirven como imágenes optimizadas y las preferencias se guardan en este dispositivo.

Si macOS bloquea el archivo al abrirlo, haz clic derecho en `iniciar.command` y elige **Abrir**.

## Funciones

- Visor del PDF completo de 120 páginas, con navegación por número, botones y flechas del teclado.
- Las páginas siempre se representan directamente desde el PDF original. Ningún texto traducido se dibuja encima de la página.
- OCR auténtico con zonas transparentes para las páginas 7–14 (unidades 1–4). Pasa el cursor o haz clic en las palabras resaltadas para consultar vocabulario; la selección de frase está en el panel «Traducir página».
- Síntesis de voz del navegador, lista personal de vocabulario y guardado del progreso.
- Diccionario inicial centrado en licencias, normativa, turnos, condiciones de trabajo y términos de taxi.

La traducción de frase del prototipo es orientativa: compone las equivalencias disponibles en el glosario y deja visibles los términos que todavía no estén traducidos. No sustituye una traducción editorial revisada. Los controles Original, Traducción y Bilingüe conservan siempre la página original y muestran el apoyo de lectura en el panel lateral.

## Ampliar la cobertura OCR

El archivo `assets/ocr-pages.json` contiene una lista de registros con número de página y palabras. Cada palabra tiene `text`, `x`, `y`, `w`, `h` y `confidence`; las cuatro coordenadas son fracciones de la página (0–1), con origen en la esquina superior izquierda. Para ampliar el libro, añade registros con el mismo esquema para las páginas que falten. El visor los coloca automáticamente sobre sus respectivas páginas. El PDF completo ya está enlazado; solo hay que extender los datos OCR y el glosario.

El prototipo no simula OCR en páginas que aún no se han procesado: en ellas se indica que la página original está disponible y que el OCR se puede ampliar.

## Estructura

```text
index.html                 interfaz
styles.css                 diseño adaptable
app.js                     visor, navegación, OCR, glosario y estudio
public/assets/pages/       páginas originales rasterizadas para la web
public/assets/ocr-pages.json OCR y coordenadas para las páginas 7–14
wrangler.jsonc             configuración de Cloudflare Workers
iniciar.command            servidor local y apertura del navegador
```
