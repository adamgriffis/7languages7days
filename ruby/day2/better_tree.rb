class Tree 
  attr_accessor :children, :node_name

  def initialize(hash)
    @node_name = hash.keys.first

    children_hashes = hash[@node_name]

    @children = []
    children_hashes.each do |key, value|
      @children << Tree.new({key => value})
    end
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block }
  end

  def visit(&block)
    block.call self
  end
end

puts "Visiting a node"
ruby_tree = Tree.new({ "Ruby" => {"Reia" => {"Reia1" => {}, "Reia2" => {}}, "MacRuby" => {}}})
ruby_tree.visit { |node| puts node.node_name }
puts

puts "Visiting entire tree"
ruby_tree.visit_all { |node| puts node.node_name }