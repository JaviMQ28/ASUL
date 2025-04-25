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
' | awk -F ';' '{print($7)}' | sort -u | tr -d '"' | tr -d ',' | tr '\n' ' ')

echo $users

# Llaves ssh publicas
keys=$(tail -n +2 ASUL\ 25-1\ Datos\ debian\ -\ Respuestas\ de\ formulario\ 1\ -\ MODIFICADO.csv| perl -pe '
  s{
    (?:^|,)(?=(?:(?:[^"]*"){2})*[^"]*$) 
  }{
    $& eq "," ? ";" : $&
  }egx
' | awk -F ';' '{print($8)}' | sort -u | tr -d '"' | tr ',' '\n')

echo $keys

# Nombres de host
host1=$(echo "$computers" | head -n 1)
host2=$(echo "$computers" | sed -n '2p')
host3=$(echo "$computers" | sed -n '3p')
host4=$(echo "$computers" | sed -n '4p')
host5=$(echo "$computers" | sed -n '5p')
host6=$(echo "$computers" | sed -n '6p')
host7=$(echo "$computers" | sed -n '7p')
host8=$(echo "$computers" | sed -n '8p')
host9=$(echo "$computers" | sed -n '9p')

# Declarar arreglo asociativo
declare -A host_table

# Asignar valores al arreglo
host_table["eq1"]=$host1
host_table["eq2"]=$host2
host_table["eq3"]=$host3
host_table["eq4"]=$host4
host_table["eq5"]=$host5
host_table["eq6"]=$host6
host_table["eq7"]=$host7
host_table["eq8"]=$host8
host_table["eq9"]=$host9

table="hosts.csv"
if [ -f "$table" ]; then
    echo "* La tabla de hosts ($table) ya existe"
fi

# Recorrer todos los elementos
echo -e "\n--- Tabla estatica de hosts ---"
for host in "${!host_table[@]}"; do
    echo "$host => ${host_table[$host]}" 
    if [ ! -f "$table" ]; then
    	echo "$host, ${host_table[$host]}" >> $table
    fi
done

# Crear cuentas de usuario
# Nombres de usuarios
user1=$(echo "$users" | tr ' ' '\n' | head -n 1)
user2=$(echo "$users" | tr ' ' '\n' | sed -n '2p')
user3=$(echo "$users" | tr ' ' '\n' | sed -n '3p')
user4=$(echo "$users" | tr ' ' '\n' | sed -n '4p')
user5=$(echo "$users" | tr ' ' '\n' | sed -n '5p')
user6=$(echo "$users" | tr ' ' '\n' | sed -n '6p')
user7=$(echo "$users" | tr ' ' '\n' | sed -n '7p')
user8=$(echo "$users" | tr ' ' '\n' | sed -n '8p')
user9=$(echo "$users" | tr ' ' '\n' | sed -n '9p')
user10=$(echo "$users" | tr ' ' '\n' | sed -n '10p')
user11=$(echo "$users" | tr ' ' '\n' | sed -n '11p')
user12=$(echo "$users" | tr ' ' '\n' | sed -n '12p')
user13=$(echo "$users" | tr ' ' '\n' | sed -n '13p')
user14=$(echo "$users" | tr ' ' '\n' | sed -n '14p')
user15=$(echo "$users" | tr ' ' '\n' | sed -n '15p')
user16=$(echo "$users" | tr ' ' '\n' | sed -n '16p')
user17=$(echo "$users" | tr ' ' '\n' | sed -n '17p')
user18=$(echo "$users" | tr ' ' '\n' | sed -n '18p')
user19=$(echo "$users" | tr ' ' '\n' | sed -n '19p')
user20=$(echo "$users" | tr ' ' '\n' | sed -n '20p')
user21=$(echo "$users" | tr ' ' '\n' | sed -n '21p')
user22=$(echo "$users" | tr ' ' '\n' | sed -n '22p')
user23=$(echo "$users" | tr ' ' '\n' | sed -n '23p')
user24=$(echo "$users" | tr ' ' '\n' | sed -n '24p')
user25=$(echo "$users" | tr ' ' '\n' | sed -n '25p')
user26=$(echo "$users" | tr ' ' '\n' | sed -n '26p')
user27=$(echo "$users" | tr ' ' '\n' | sed -n '27p')

# Declarar arreglo asociativo
declare -A user_table

# Asignar valores al arreglo: Usuario -> Llave publica ssh
user_table["$user1"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '28p')
user_table["$user2"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '29p')
user_table["$user3"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '30p')
user_table["$user4"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '32p')
user_table["$user5"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '31p')
user_table["$user6"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '17p')
user_table["$user7"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '27p')
user_table["$user8"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '10p')
user_table["$user9"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '9p')
user_table["$user10"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '15p')
user_table["$user11"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '16p')
user_table["$user12"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-ed25519/ssh-ed25519 /' | sed -E 's/^(ssh-ed25519 )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '1p')
user_table["$user13"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-ed25519/ssh-ed25519 /' | sed -E 's/^(ssh-ed25519 )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '2p')
user_table["$user14"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-ed25519/ssh-ed25519 /' | sed -E 's/^(ssh-ed25519 )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '3p')
user_table["$user15"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '14p')
user_table["$user16"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '11p')
user_table["$user17"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '12p')
user_table["$user18"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '13p')
user_table["$user19"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '8p')
user_table["$user20"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '5p')
user_table["$user21"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '7p')
user_table["$user22"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '6p')
user_table["$user23"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '4p')
user_table["$user24"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '23p')
user_table["$user25"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '24p')
user_table["$user26"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '25p')
user_table["$user27"]=$(echo "$keys" | tr -d ' ' | sed 's/^ssh-rsa/ssh-rsa /' | sed -E 's/^(ssh-rsa )([^ ]+?=+)(.+)$/\1\2 \3/' | sed -n '26p')

# Recorrer todos los elementos
echo -e "\nUsuarios:"
for user in "${!user_table[@]}"; do
    echo "$user => ${user_table[$user]}" 
done

# Convertir la lista de usuarios a un array
read -r -a users_array <<< "$users"

echo -e "\n--- Creacion de cuentas de usuario ---"
for user in "${users_array[@]}"; do
    # Crear el usuario si no existe
    if ! id "$user" &>/dev/null; then
        echo "Creando usuario $user:"
	# Contrasenia aleatoria
	password=$(mkpasswd.pl -l 15 -C 3 -c 3 -d2 2>/dev/null)
	echo " - Contrasenia: $password"
	# Encripta contrasenia con sal wtf
	pass=$(perl -e 'print crypt($ARGV[0], "wtf")' "$password")
        sudo useradd -m -s /bin/bash -p "$pass" "$user"
    else
	echo "* El usuario $user ya ha sido creado"
    fi
done

echo -e "\n--- Configuracion de llave publica ---"
for user in "${users_array[@]}"; do
    # Crear directorio .ssh y agregar llave
    if [ ! -e "/home/$user/.ssh" ]; then
	ssh_dir="/home/$user/.ssh"
        sudo mkdir -p "$ssh_dir"
        sudo chmod 700 "$ssh_dir"
        echo "${user_table[$user]}" | sudo tee "$ssh_dir/authorized_keys" > /dev/null
        sudo chmod 600 "$ssh_dir/authorized_keys"
        sudo chown -R "$user:$user" "$ssh_dir"
	echo "Usuario $user configurado con su llave"
    else
	echo "* El usuario $user ya fue configurado con su llave"
    fi
done

#for user in "${users_array[@]}"; do
    # Eliminar el usuario
    #if id "$user" &>/dev/null; then
        #echo "Eliminando usuario $user..."
        #sudo userdel -r "$user"
    #fi
#done
