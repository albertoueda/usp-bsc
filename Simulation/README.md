1. Configuração do ambiente de desenvolvimento
==============================================

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

> É possíve voltar para a versão do ruby instalada no sistema com o comando:
> 			rvm use system

### Gem ###

Dependências do simulador

1. Chipmunk

			gem install chipmunk

2. Gosu
	
			gem install gosu

3. Chingu

			gem install chingu

4. Visual Ruby

			gem install visualruby

### Glade ###

Glade é uma IDE que facilita o desenvolvimento de interface. Visual Ruby é responsável por intergrar glade com ruby.

1. Instalação do editor

			sudo apt-get install glade-gnome	
