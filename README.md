Simulação e Integração de conceitos físicos na computação
=========================================================

1. Introdução
-------------
  Projeto feito em Ruby integrado com:  
  * Chipmunk: Framework para simulações físicas
  * Gosu + Chingu: Framework para desenvolver jogos
  * Visual Ruby: Gem que facilita a integração entre Ruby e Glade 

2. Organização do projeto
-------------------------

* proposta: Página HTML com a proposta do projeto.
* Simulation: Pasta com as demonstrações de diversos ambientes físicos.
  - bin/ Pasta com as configurações da interface inicial. (Glade + Ruby)
  - demos/ Arquivos .rb com a simulação. Qualquer arquivo de
demonstração deve ficar nesta pasta 
    * config/ Arquivo de configuração
    * lib/ Biblioteca para adicionar propriedades físicas ao Chingu
    * images/ Imagens
    * media/ Imagens + Sons

3. Execução
-----------

Para rodar a simulação, executar:
    ruby main.rb
localizado na pasta Simulation

4. Tarefas
----------

O que já foi feito:

1. Ambientes de demonstração com cenários focando em difernetes conceitos físicos
2. Montar um ambiente fácil de demonstração para o professor usar nas
   aulas, para criação de cenários físicos

