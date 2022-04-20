#!/bin/sh
ROM=sml.gb
rev=$(xxd -p -l 1 -s 332 $ROM | cut -c 2-2)
echo "ROM revision: v1.$rev"

if test -f "smldx.gbc"
then
    rm smldx.gbc
fi
if test -f "smldx.sav"
then
    rm smldx.sav
fi
(echo "[objects]" && echo "smldx.obj") > temp.prj
wla-gb -D REV=$rev -o smldx.obj main.asm
wlalink -s temp.prj smldx.gbc
rm temp.prj smldx.obj

if test -f "smldx.gbc"
then
	echo "Success!"
else
	echo "Something went wrong."
fi