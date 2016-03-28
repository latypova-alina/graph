class GraphAllFolders

  class << self

    def get_graph
      g = GraphViz.digraph( "G" ) { |g|
        g[:splines] = 'line'
      }
      g[:rankdir] = "LR"
      return g
    end


    private def devide_attributes (attributes)
      string = ''
      attributes.each do |attribute|
        string = string + '\n' + attribute #считывает из документа атрибуты и записывает их в столбик
      end
      return string
    end


    protected def make_links(base, g) #построение графа
        parent = base ['parent']
        inc = base['include']
        if base['attributes']
          attributes = base['attributes'].keys
          d = document + '\n' + '----------' + devide_attributes(attributes) #записывает в узел графа атрибуты
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

    def print (graph_obj, graph)


      graph_obj.make_links(base, graph)

      graph.output( :png => "common_graph.png" )

    end

  end
  end

  #graph_obj = GraphAllFolders.new
  #graph = graph_obj.get_graph
  #graph = graph_obj.print(graph_obj, graph)





 
