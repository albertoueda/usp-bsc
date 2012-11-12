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

O que já foi feito:

1. Ambientes de demonstração com cenários focando em difernetes conceitos físicos
2. Montar um ambiente fácil de demonstração para o professor usar nas
   aulas, para criação de cenários físicos

O que falta fazer (Monografia):
1. Tutorial básico de criação de simulação
2. Escrever sobre as simulações pré-compiladas
3. Colocar referências das imagens utilizadas ao longo do trabalho  

Tarefas Extras:
1. Extra Criar aulas 'embutidas' no programa.
2. Implementar um algoritmo diferente usado para detectar colisões

6. Para discutir
----------------

1. Chipmunk C++
	* Muitas referências na net estão em C++, além de ter bem mais métodos que o wrapper. Vale a pena mexer tbm no código em C++ se precisarmos? Devemos dar instruções na monografia para modificações do código nativo?  
2. Aulas embutidas



