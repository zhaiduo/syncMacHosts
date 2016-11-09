#/bin/bash

#for sed: http://www.grymoire.com/Unix/Sed.html
#echo "/usr/local/bin/fish" | sudo tee -a /private/etc/hosts

if [ "$1" == "" ]; then
  echo Usage: $0 ip domain
  echo i.e.: 0.0.0.0 baidu.com
  exit 0
fi

if [ "$2" == "" ]; then
  echo Usage: $0 ip domain
  echo i.e.: 0.0.0.0 baidu.com
  exit 0
fi

sudo sed -i bak -E '
/^[0-9\.]+[ ]+'${2}'/{
s/^[0-9\.]+/'${1}'/
h
}
${
x
/./ba
x
s/$/\
'${1}' '${2}'/
x
:a
x
}' /private/etc/hosts

