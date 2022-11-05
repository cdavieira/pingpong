# Anotações
- alguns textos estao configurados de forma hardcoded, por isso nem todos seguem as especificacoes contidas no arquivo config
- talvez usar interrupcao int15h ah=86h para funcao delay (interrupcao trabalha com microsegundos)
- talvez usar interrupcao int21h ah=25h para configurar vetor de interrupcao inicial
- talvez usar interrupcao int10h ah=0bh para setar a cor de fundo do modo de video (talvez nao funcione)
- medir quantos fps o jogo apresenta atualmente

# Prioridades
1. talvez mudar a forma como o retangulo do jogador eh renderizado (em vez de apagar o circulo inteiro, apenas apagar as linhas de borda, iniciais e finais e redesenhalas)
2. fazer com que a bolinha comece o jogo randomicamente numa regiao definida da tela (usar resb e mascaramento para manipular a posicao inicial)
