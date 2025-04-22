# !/bin/bash

# Computadoras
computers=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1.csv | perl -pe ' s{ (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) }{ $& eq "," ? ";" : $& }egx ' | awk -F ',' '{print $4}' | awk 'BEGIN{RS=""}{gsub(/\n/, " "); print}')

echo $computers

# IPsV4
ip4s=$( tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1.csv | perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$)  # Detecta comas

  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ',' '{print $5}' | awk 'BEGIN{RS=""}{gsub(/\n/, " "); print}')

echo $ip4s

# IPsV6
ip6s=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1.csv | perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ',' '{print $6}' | awk 'BEGIN{RS=""}{gsub(/\n/, " "); print}')

echo $ip6s

# Usuarios -> No recupera los que tienen un salto de linea
users=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1.csv | perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$)  # detecta comas fuera de comillas
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ',' '{print $7}' | awk 'BEGIN{RS=""}{gsub(/\n/, " "); print}')

echo $users
