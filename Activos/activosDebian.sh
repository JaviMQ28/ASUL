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

echo $computers

# IPsV4
ip4s=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($5)}' | sort -u)

echo $ip4s

# IPsV6
ip6s=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($6)}' | sort -u)

echo $ip6s

# Usuarios
users=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($7)}' | sort -u | tr -d '"' | tr ',' ' ')

echo $users

# Llaves ssh publicas
keys=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($8)}' | sort -u | tr -d '"' | tr ',' ' ')

echo $keys


# Verificar computadoras que estan activas
file="activas.txt"

# Limpiar archivo
> "$file"

echo ""
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
