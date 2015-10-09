class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max,false)
  end

  def insert(value)
    validate!(value)
    @store[value] = true unless value > @max
  end

  def remove(value)
    validate!(value)
    @store[value] = false unless value > @max
  end

  def include?(value)
    validate!(value)
    @store[value]
  end

  private

  def is_valid?(num)
    num.between?(0,@max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end



class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) {Array.new}
  end

  def insert(value)
    modded_value = value % @store.length
    @store[modded_value] << value
  end

  def remove(value)
    modded_value = value % @store.length
    @store[modded_value].delete(value)
  end

  def include?(value)
    modded_value = value % @store.length
    @store[modded_value].include?(value)
  end

  private

  def num_buckets
    @store.length

  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(value)
    modded_value = value % num_buckets
    @store[modded_value] << value
    @count += 1
    resize! if num_buckets == @count
  end



  def remove(value)
    modded_value = value % @store.length
    @store[modded_value].delete(value)
  end

  def include?(value)
    modded_value = value % @store.length
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
    count = @count
    old_store.flatten.each do |el|
      insert(el)
      @count = count
    end

  end
end
