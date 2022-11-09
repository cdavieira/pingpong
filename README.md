# Comandos do MAKEFILE
#### Digite os seguintes comandos no terminal do MSDOS

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

# Anotações
- alguns textos estao configurados de forma hardcoded, por isso nem todos seguem as especificacoes contidas no arquivo config
- a interrupcao int21h ah=25h pode tambem ser usada para configurar o vetor de interrupcao inicial
- a interrupcao int10h ah=0bh poderia talvez ser usada para setar a cor de fundo do modo de video (necessario testar para o emulador de terminal em uso)

# Ideias
1. redesenhar o menu de selecao de 2 em 2 caixas, em vez das 3
2. fazer com que a bolinha comece o jogo randomicamente numa regiao definida da tela
