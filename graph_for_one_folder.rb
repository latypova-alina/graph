
require "yaml"
require 'graphviz/family_tree'

g = GraphViz.new( :G, :type => :digraph )
g[:rankdir] = "LR"
def devide_attributes (attributes)
	string = ''
  	attributes.each do |attribute|
  		string = string + '\n' + attribute
  	end
  	return string
  end


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
  g.add_nodes(d)
  g.add_nodes( parent )
  g.add_nodes ( inc ) if inc


  g.add_edges( parent, d)
  g.add_edges( inc, document, color: "green") if inc


  g.output( :png => "graph_one_folder.png" )
  




end


