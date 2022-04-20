$ROM = './sml.gb'
$rev = (Get-Content $ROM -Encoding Byte -ReadCount 1)[332]
echo "ROM revision: v1.$rev"

if (Test-Path -Path "./smldx.gbc" -PathType Leaf){
	rm smldx.gbc
}
if (Test-Path -Path "./smldx.sav" -PathType Leaf){
	rm smldx.sav
}
echo "[objects]`r`nsmldx.obj" | out-file -encoding ASCII temp.prj
wla-gb -D REV=$rev -o smldx.obj main.asm
wlalink -s temp.prj smldx.gbc
rm temp.prj, smldx.obj

if (Test-Path -Path "./smldx.gbc" -PathType Leaf){
	echo "Success!"
}else{
	echo "Something went wrong."
}