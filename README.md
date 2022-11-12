# Sobre o projeto
Jogo de pingpong escrito em assembly para o processador intel 8086/8088, progenitor da familia x86. Autor: Carlos Daniel Albertino Vieira.

# Como o jogo se parece
<div>
<p align="center">
<img src="/ASSETS/menu.png" alt="Menu Inicial">
<img src="/ASSETS/loading-screen.png" alt="Tela de carregamento">
<img src="/ASSETS/gameplay.png" alt="Jogo">
</p>
</div>

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
