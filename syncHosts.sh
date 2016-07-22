#/bin/bash

#for sed: http://www.grymoire.com/Unix/Sed.html

if [ "$1" == "" ]; then
  echo Usage: $0 ip domain
  echo i.e.: 0.0.0.0 baidu.com
  exit 0
fi

#echo `echo ${1} | sed -E '/^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/{p;}'`

if [ "$2" == "" ]; then
  echo Usage: $0 ip domain
  echo i.e.: 0.0.0.0 baidu.com
  exit 0
fi

sed -E '
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
}' hosts

