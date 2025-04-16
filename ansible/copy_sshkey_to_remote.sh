#!/bin/bash


while [ -n "$1" ]
do
case "$1" in
--rpass) rpass="$2"
shift ;;
--key-path) pubkey="$2"
shift ;;
--ruser) ruser="$2" 
shift ;;
--hosts-file) hosts="$2"	
shift ;;
--help) echo "
Данный скрипт позволяет скопировать открытый SSH ключ на удаленные хосты

ИНCТРУКЦИЯ:

--ruser      - необходимо указать пользователя на удаленном хосте

--rpass      - необходимо указать пароль пользователя на удаленном хосте

--key-path   - необходимо указать путь до файла с публичным SSH ключом, который будет скопирован на удаленные хосты

--hosts-file - необходимо указать файл со списком удаленных хостов, на которые будет копироваться SSH ключ

ПРИМЕР ВВОДА КОМАНДЫ:

./copy_sshkey_to_remote.sh --ruser vasya --rpass 12345 --key-path ~/.ssh/id_rsa.pub --hosts-file ./remote-hosts.txt


";;
*) echo "$1 is not an option"
break ;;
esac
shift
done

while read line; do
        sshpass -p $rpass  ssh-copy-id -i $pubkey -o "StrictHostKeyChecking no" $ruser@$line
done < "$hosts"
