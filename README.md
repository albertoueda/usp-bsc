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
localizado em na pasta Simulation

4. Tarefas
----------

1. Tutorial básico de criação de simulação.
2. Implementar algoritmos para "passos de tempo" para explicar a
   diferença entre elas
3. Implementar um algoritmo diferente usado para detectar colisões
4. Demo de um ep integrado com o programa.
5. Montar um ambiente fácil de demonstração para o professor usar nas
   aulas
6. Criar aulas 'embutidas' no programa.
