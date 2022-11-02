call .\bat\EXPORT.BAT
if "%1"=="run" call .\bat\RUN.BAT
if "%1"=="debug" call .\bat\DEBUG.BAT
if "%1"=="clean" call .\bat\CLEAR.BAT
if "%1"=="rebase" call .\bat\REBASE.BAT
if "%1"=="menu" %exeFolder%\nasm16 -f obj -o %objFolder%\menu.obj -l %lstFolder%\menu.lst %asmFolder%\menu.asm
if "%1"=="main" %exeFolder%\nasm16 -f obj -o %objFolder%\main.obj -l %lstFolder%\main.lst %asmFolder%\main.asm
if "%1"=="data" %exeFolder%\nasm16 -f obj -o %objFolder%\data.obj -l %lstFolder%\data.lst %asmFolder%\data.asm
if "%1"=="bg" %exeFolder%\nasm16 -f obj -o %objFolder%\bg.obj -l %lstFolder%\bg.lst %asmFolder%\bg.asm
if "%1"=="gameloop" %exeFolder%\nasm16 -f obj -o %objFolder%\gameloop.obj -l %lstFolder%\gameloop.lst %asmFolder%\gameloop.asm
if "%1"=="anim" %exeFolder%\nasm16 -f obj -o %objFolder%\anim.obj -l %lstFolder%\anim.lst %asmFolder%\anim.asm
if "%1"=="" call .\bat\COMP.BAT
if "%1"=="link" call .\bat\LINK.BAT
