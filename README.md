# Sobre o projeto
Jogo de pingpong escrito em assembly para o processador intel 8086/8088, progenitor da familia x86.

# Como o jogo se parece
![Menu inicial](/ASSETS/menu.png)
![Tela de carregamento](/ASSETS/loading-screen.png)
![Jogo](/ASSETS/gameplay.png)

# Comandos de build
#### Digite os seguintes comandos no terminal do MSDOS
###### Emulador de terminal MSDOS recomendado: dosbox

Para gerar todos os arquivos objetos:

`make`

Para atualizar um unico arquivo objeto:

`make update arquivo`

Para linkar os arquivos objetos produzidos e gerar o executavel final:

`make link`

Para rodar o executavel final:

`make run`

Para debugar o programa:

`make debug`

Para remover os arquivos objetos e os arquivos de listagem:

`make clean`

Para remover os arquivos objetos, os arquivos de listagem e suas pastas:

`make rebase`

# Avisos
- Alguns textos estao configurados de forma hardcoded, por isso nem todos seguem as especificacoes contidas no arquivo config
