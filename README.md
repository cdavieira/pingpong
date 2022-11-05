# Anotações
- melhorar qualidade da bolinha (nao parece cor solida no momento)
- alguns textos estao configurados de forma hardcoded, por isso nem todos seguem as especificacoes contidas no arquivo config

# Prioridades
1. botoes de movimento (j e k) deveriam ser setas direita e esquerda (mudar a variavel de byte para word, talvez mudar algumas partes do codigo e avaliar se as setas direita e esquerda sao identificadas assim)
2. talvez mudar a forma como o retangulo do jogador eh renderizado (em vez de apagar o circulo inteiro, apenas apagar as linhas de borda, iniciais e finais e redesenhalas)
3. fazer com que a bolinha comece o jogo randomicamente numa regiao definida da tela (usar resb e mascaramento para manipular a posicao inicial)
