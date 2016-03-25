require "yaml"
require 'graphviz'



g = GraphViz.digraph( "G" ) { |g|
  g[:splines] = 'line'
  
}
g[:rankdir] = "LR"
def devide_attributes (attributes)
	string = ''
  	attributes.each do |attribute|
  		string = string + '\n' + attribute
  	end
  	return string
  end


def make_links (directory, g) 
  
  
  Dir.chdir(directory)
  
  Dir.glob('*.yml').each do |document|
    base = YAML.load_file(document)

    parent = base ['parent']
    inc = base['include']
    if base['attributes']
  	  attributes = base['attributes'].keys
  	  d = document + '\n' + '----------' + devide_attributes(attributes)
    else
  	  d = document
    end
    if inc 
      g.add_nodes(inc)
      g.add_edges(inc, d, color: 'green')
    end 
    g.add_nodes( parent)
    g.add_nodes(d)
    g.add_edges( parent, d)
    
  
end


end

folders = Dir.entries('./').select {|entry| File.directory? File.join('./',entry) and !(entry =='.' || entry == '..') }
folders.each do |f|
	make_links(f, g)
	Dir.chdir('../')
end






g.output( :png => "common_graph.png" )


