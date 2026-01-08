#!/bin/bash

# Script de optimización para (IdeaPad Slim 3)
# Basado en Ubuntu 24.04 con Kernel 6.14.0-37

echo "--- Iniciando optimización de memoria ---"
echo 
free -m

# 1. Sincronizar datos pendientes en disco para evitar pérdida de información
sync

# 2. Liberar PageCache, dentries e inodes (Caché del sistema)
# Esto libera la memoria que el sistema usa para agilizar archivos, devolviéndola a tus aplicaciones.
echo "Limpiando caché del sistema..."
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

# 3. Limpiar la memoria de intercambio (Swap)
# Útil si el sistema ha movido datos a tu NVMe Micron de 512GB, lo que puede ralentizar procesos.
echo "Reiniciando el área de intercambio (esto puede tardar unos segundos)..."
sudo swapoff -a && sudo swapon -a

# 4. Limpiar residuos de paquetes de instalación (Apt)
# Ayuda a mantener limpio tu volumen EXT4 de 107GB.
echo "Limpiando paquetes innecesarios..."
sudo apt-get clean
sudo apt-get autoremove -y

# 5. Vaciar la papelera de reciclaje desde la terminal
rm -rf ~/.local/share/Trash/*

echo "--- Optimización completada ---"
free -m
