require 'haml'


# Métodos utilitários
def is_active(filename, actual_filename)
  return "active" if filename == actual_filename
  return ""
end

#
def import_markdown(file_path)
  begin
    File.read file_path
  rescue Exception => e
    puts "Erro ao tentar ler #{file_path}: #{e}"
  end
end

# Script para gerar o site.
template = File.read 'template.haml'
haml_engine = Haml::Engine.new template

Dir['*.content.haml'].each do
	|file|
	output_file_name = File.basename(file, ".content.haml") + ".html"
	contents = File.read file

	output = haml_engine.render Object.new, {contents: Haml::Engine.new(contents).render, filename: output_file_name}

	File.open output_file_name, "w" do
		|file|
		file.write output
	end

	puts "Arquivo #{output_file_name} foi criado"
end

