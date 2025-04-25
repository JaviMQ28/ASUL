#!/bin/bash

# Recuperar datos del csv
# Computadoras
computers=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($4)}' | sort -u)

#echo $computers

# IPsV4
ip4s=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($5)}' | sort -u)

#echo $ip4s

# IPsV6
ip6s=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($6)}' | sort -u)

#echo $ip6s

# Usuarios
users=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($7)}' | sort -u | tr -d '"' | tr -d ',' | tr '\n' ' ')

#echo $users

# Llaves ssh publicas
keys=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($8)}' | sort -u | tr -d '"' | tr ',' '\n')

#echo $keys


# Verificar computadoras que estan activas
file="activos.txt"

# Limpiar archivo
> "$file"

echo "--- Computadoras activas ---"
echo "--- Computadoras activas ---" >> "$file"
actives=()

for ip in $ip4s; do
    if ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
	echo "Activa: $ip" 
	echo "$ip" >> "$file"
        actives+=("$ip")
    else 
	echo "No activa: $ip"
    fi
done

echo -e "\n--- Usuarios conectados ---"
echo -e "\n--- Usuarios conectados ---" >> "$file"

# Usuario que se usara para conectarse
ssh_user="javiermq"

# Iterar sobre IPs activas
for ip in "${actives[@]}"; do
    echo "Verificando IP: $ip"
    ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no "$ssh_user@$ip" 'who' 2>/dev/null | while read -r line; do
        user=$(echo "$line" | awk '{print $1}')
        login_from=$(echo "$line" | grep -oP "\(.*?\)" | tr -d '()')
        echo "Usuario conectado: $user desde $login_from"
	echo "$user" >> "$file"
    done
done

echo -e "\n--- Tiempo del sistema activo ---"
echo -e "\n--- Tiempo del sistema activo ---" >> "$file"

# Iterar sobre IPs activas
for ip in "${actives[@]}"; do
    tiempo_activo=$(ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no "$ssh_user@$ip" 'uptime -p' 2>/dev/null)
    echo "$ip ($ssh_user): $tiempo_activo"
    echo "$ip ($ssh_user): $tiempo_activo" >> "$file"
done

echo -e "\n * Se ha guardado la informacion en $file"
