Simulação e Integração de conceitos físicos na computação
=========================================================

1. Configuração do ambiente de desenvolvimento
----------------------------------------------

### Ruby Version Manager (RVM) ###

[RVM](https://rvm.io/rvm/install) (Ruby Version Manager) é um gerenciador de versões de Ruby. Podemos ter várias versões de ruby instalado na máquina e ainda podemos ter essa configuração por projeto.

1. Baixar o script rvm e instalar
			
			curl -L https://get.rvm.io | bash -s stable

2. Definir variaveis de ambiente (Colocar o comando no .bashrc)
		
			source ~/.rvm/scripts/rvm
	
3. Verificar se o RVM foi instalado corretamente

			type rvm | head -n 1
			rvm is a function

### Ruby 1.9.3 ###

[Ruby 1.9.3](http://ruby-doc.org/core-1.9.3/) vem com atualizações interessantes que facilita e agiliza mais ainda o desenvolvimento de programas nesta linguagem.
Vamos instalar utilizando o rvm

1. Instalando o ruby 1.9.3 com rvm

			rvm install 1.9.3

2. Verificando as versões intaladas

			rvm list

3. Definindo a versão do ruby que será utilizado

			rvm use 1.9.3

> É possíve voltar para a verrsão do ruby instalada no sistema com o comando:
> 			rvm use system

		

	

2. Introdução
-------------
  Projeto feito em Ruby integrado com:  
  * Chipmunk: Framework para simulações físicas
  * Gosu + Chingu: Framework para desenvolver jogos
  * Visual Ruby: Gem que facilita a integração entre Ruby e Glade 

3. Organização do projeto
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

4. Execução
-----------

Para rodar a simulação, executar:
    ruby main.rb
localizado em na pasta Simulation

5. Tarefas
----------

1. Tutorial básico de criação de simulação.
2. Implementar algoritmos para "passos de tempo" para explicar a
   diferença entre elas
3. Implementar um algoritmo diferente usado para detectar colisões
4. Demo de um ep integrado com o programa.
5. Montar um ambiente fácil de demonstração para o professor usar nas
   aulas
6. Criar aulas 'embutidas' no programa.
