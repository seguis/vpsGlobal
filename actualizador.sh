#!/bin/bash

# URL remota del script
URL="https://tudominio.com/update.sh"
LOCAL="/usr/local/bin/update.sh"
VERSION_LOCAL="/var/lib/actualizador/version.txt"
VERSION_REMOTE_URL="https://tudominio.com/version.txt"

# Crear directorios si no existen
mkdir -p /var/lib/actualizador

# Descargar versión remota
VERSION_REMOTA=$(curl -fsSL "$VERSION_REMOTE_URL")

# Leer versión local
if [ -f "$VERSION_LOCAL" ]; then
    VERSION_LOCAL_VAL=$(cat "$VERSION_LOCAL")
else
    VERSION_LOCAL_VAL="none"
fi

# Comparar versiones
if [ "$VERSION_LOCAL_VAL" != "$VERSION_REMOTA" ]; then
    echo "[INFO] Nueva versión detectada: $VERSION_REMOTA"
    curl -fsSL "$URL" -o "$LOCAL"
    chmod +x "$LOCAL"
    echo "[INFO] Ejecutando actualización..."
    bash "$LOCAL"
    echo "$VERSION_REMOTA" > "$VERSION_LOCAL"
else
    echo "[INFO] No hay actualizaciones."
fi