#!/bin/bash

echo "=== Logs do Sistema ==="
echo "Data/hora: $(date)"
echo "Uso de CPU: $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
echo "Memória livre: $(free -h | grep Mem | awk '{print $4}')"
echo "Processos em execução: $(ps aux | wc -l)"