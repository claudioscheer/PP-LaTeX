#! /bin/bash
##
## Copyright (C) 2012 Ricardo Piccoli <rfbpiccoli at gmail dot com>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
##
# sort.sh: ordena as listas de abreviaturas e siglas para o
# formato LaTeX do modelo de teses, monografias e dissertações do
# PPGCC/PUCRS (2009).
#
# Requer uma distribuição UNIX com os utilitários 'sort', 'mv' e
# 'bash'. Estes são comumente encontrados na maioria das
# distribuições UNIX, ou ainda, Cygwin e MinGW para sistemas
# Windows.
#
# !!ATENÇÃO!! O uso incorreto deste script pode causar a perda ou
# sobrescrita de arquivos no diretório onde estiver sendo
# utilizado! Examine este arquivo com cuidado e, em caso de
# dúvidas, NÃO o utilize para compilar o seu documento! Não me
# responsabilizo pela perda acidental de arquivos!

function abort() {
   echo "$@" > /dev/stderr
   exit 1
}

function check() {
   command -v $1 >& /dev/null || abort "Utilitário '$1' não encontrado. Abortando..."
}

FILE="$1"
CLS="pucrs-ppgcc.cls"

if [[ $# -lt 1 ]]; then
    abort "Sintaxe: $0 <documento.tex>."
fi

if [[ ! -f "${FILE}.loa" ]] ||\
   [[ ! -f "${FILE}.lob" ]]; then
# FIXME O usuário pode simplesmente não estar usando estas
# listas, então deve-se sair silenciosamente.
#   abort "Execute o LaTeX pelo menos uma vez sobre o documento '${FILE}', utilizando a classe '$CLS'."
   exit 0
fi

check mv
check sort

for i in a b; do
    LFILE="${FILE}.lo${i}"
    sort -d -f -o "${LFILE}~" "$LFILE" &&\
    mv -f "${LFILE}~" "$LFILE"
done

echo "'$0 $@' concluído." > /dev/stderr
exit 0