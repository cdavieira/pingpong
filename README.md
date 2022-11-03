# Anotações
## fazer com que a bolinha comece o jogo randomicamente numa regiao definida da tela (usar resb e mascaramento para manipular a posicao inicial)
## carregar mensagem de pause
## dar um jeito da mensagem de loading nao ser sobreescrita pelo fundo enquanto esse for sendo carregado
## o nome da variavel playerAction eh ruim, porque no fundo o que ela controla é se o retangulo do jogador pode ou nao ser desenhado, e em algumas situações, mesmo que o jogador performe uma ação, a posicao do retangulo nao sera atualizada (ex: quando atingir uma borda)
## pela mesma razao anterior, o label tecla_valida do arquivo gameloop.asm tambem nao eh fiel ao seu significado, porque faz referencia a atualizacao da variavel playerAction, indicando que o retangulo pode ser atualizado no proximo frame
