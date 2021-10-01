class Node

  attr_reader :tree
  attr_reader :id
  attr_reader :parent
  attr_reader :dependencies
  attr_reader :state
  attr_accessor :state

  def initialize(tree, id, dependencies, block)
    @tree = tree
    @id = id
    @dependencies = tree.lookup_dependencies(dependencies)
    @block = block
    @state = :pending
  end

  def has_dependencies?
    dependencies.length != 0
  end

  def __each_dependency(check_list, &block)
    yield self if check_list.add?(self)
    dependencies.each do |d|
      d.__each_dependency(check_list, &block)
    end
   end


  def each_dependency(&block)
     return enum_for(:each_dependency) unless block_given?
     __each_dependency(Set.new, &block)
   end

  def mark_dependencies_to_recalc
    each_dependency do |n|
      n.state = :pending if n.state == :calculated
    end
  end

  def value=(value)
    @value = value
    @state = :input
    mark_dependencies_to_recalc
  end

  def unset
    @state = :pending
  end

  def calc
    @value = @block.yield(tree)
    @state = :calculated
  end

  def value
    calc if state == :pending
    @value
  end

  def to_s
    "#{id}=#{value}"
  end

end

