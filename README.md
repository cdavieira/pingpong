# Anotações
- alguns textos estao configurados de forma hardcoded, por isso nem todos seguem as especificacoes contidas no arquivo config
- talvez usar interrupcao int21h ah=25h para configurar vetor de interrupcao inicial
- talvez usar interrupcao int10h ah=0bh para setar a cor de fundo do modo de video (talvez nao funcione)

# Prioridades
1. mudar cor de apenas 2 caixas por vez no menu de selecao, em vez de todas
2. fazer com que a bolinha comece o jogo randomicamente numa regiao definida da tela (usar resb e mascaramento para manipular a posicao inicial)
