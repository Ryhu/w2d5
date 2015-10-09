require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(value)
    modded_value = value.hash % num_buckets
    @store[modded_value] << value
    @count += 1
    resize! if num_buckets == @count
  end

  def remove(value)
    modded_value = value.hash % @store.length
    @store[modded_value].delete(value)
  end

  def include?(value)
    modded_value = value.hash % @store.length
    @store[modded_value].include?(value)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.each do |el|
      insert(el)
    end

  end
end
