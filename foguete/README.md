Simulação Foguete
=================

1. Resumo

Simulação simples de duas forças gravitacionais atuando em um objeto(foguete)

2. Patch

rb_cpBody.c: Procurar todas as chamadas para rb_scan_config(..."&"...) e
trocar para rb_scan_config(..."00&"...)

1. Execução

ruby main.rb

2. Controles

Seta Direita: Acelera em direção a Lua
Seta Esquerda: Acelera em direção da terra
ESC: Fecha a janela da simulação
