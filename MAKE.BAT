call .\bat\EXPORT.BAT
if "%1"=="run" call .\bat\RUN.BAT
if "%1"=="debug" call .\bat\DEBUG.BAT
if "%1"=="clean" call .\bat\CLEAR.BAT
if "%1"=="rebase" call .\bat\REBASE.BAT
if "%1"=="" call .\bat\COMP.BAT
if "%1"=="link" call .\bat\LINK.BAT
