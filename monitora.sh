#!/bin/bash

# Colores
verde="\e[32m"
amarillo="\e[33m"
rojo="\e[31m"
reset="\e[0m"

# Fecha y hora
echo -e "\n🖥️  ${verde}Monitor del sistema - $(date)${reset}"
echo "----------------------------------------"

# CPU USAGE
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo -e "🔸 USO DE CPU: ${cpu_usage}%"

# RAM USAGE
ram_data=$(free -m | awk '/Mem:/ {print $3 " " $2}')
used_ram=$(echo $ram_data | cut -d' ' -f1)
total_ram=$(echo $ram_data | cut -d' ' -f2)
ram_percent=$(awk "BEGIN {printf \"%.1f\", ($used_ram/$total_ram)*100}")
echo -e "🔸 USO DE RAM: ${used_ram}MB / ${total_ram}MB (${ram_percent}%)"

# Evaluación del estado
echo -ne "\n📊 Estado general del sistema: "
if (( $(echo "$cpu_usage < 30.0" | bc -l) )) && (( $(echo "$ram_percent < 40.0" | bc -l) )); then
  echo -e "${verde}MUY BIEN ✅${reset}"
elif (( $(echo "$cpu_usage < 70.0" | bc -l) )) && (( $(echo "$ram_percent < 75.0" | bc -l) )); then
  echo -e "${amarillo}ACEPTABLE ⚠️${reset}"
else
  echo -e "${rojo}PESADO ❌${reset}"
fi

# Procesos más exigentes
echo -e "\n🔸 TOP 5 procesos por uso de CPU:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
#!/bin/bash
echo -e "\n🖥️  Monitor del sistema - $(date)\n"
echo "----------------------------------------"
echo "🔸 USO DE CPU:"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU usada: " $2 "%"}'

echo -e "\n🔸 USO DE RAM:"
free -h | awk '/Mem:/ {print "RAM usada: "$3 " / " $2}'

echo -e "\n🔸 TOP 5 procesos por uso de CPU:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
