@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
::rem ����/���ü�������߹��ܣ����Խ�ʡhiberfil.sys��ռ�õĴ��̿ռ�(10G����)
if {%~1}=={1} (
set param=on
echo enable pc power sleep feature, hiberfil.sys will be generated
) else (
set param=off
echo disable pc power sleep feature, No hiberfil.sys
)

powercfg -h %param%