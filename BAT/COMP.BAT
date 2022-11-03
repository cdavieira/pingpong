:: cria os objetos dos arquivos assembly
md %objFolder%
md %lstFolder%
%exeFolder%\nasm16 -f obj -o %objFolder%\main.obj -l %lstFolder%\main.lst %asmFolder%\main.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\teclado.obj -l %lstFolder%\teclado.lst %asmFolder%\teclado.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\data.obj -l %lstFolder%\data.lst %asmFolder%\data.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\menu.obj -l %lstFolder%\menu.lst %asmFolder%\menu.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\plot_xy.obj -l %lstFolder%\plot_xy.lst %asmFolder%\plot_xy.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\line.obj -l %lstFolder%\line.lst %asmFolder%\line.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\rect.obj -l %lstFolder%\rect.lst %asmFolder%\rect.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\delay.obj -l %lstFolder%\delay.lst %asmFolder%\delay.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\circ.obj -l %lstFolder%\circ.lst %asmFolder%\circ.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\gameloop.obj -l %lstFolder%\gameloop.lst %asmFolder%\gameloop.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\bg.obj -l %lstFolder%\bg.lst %asmFolder%\bg.asm
%exeFolder%\nasm16 -f obj -o %objFolder%\anim.obj -l %lstFolder%\anim.lst %asmFolder%\anim.asm
