require "byebug"
class Link

  attr_accessor :key, :val, :nxt

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @nxt = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList

  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.nxt
  end

  def last(link)
    if link.nxt.nil?
      return link
    else
      last(link.nxt)
    end
  end

  def empty?
    self.empty?
  end

  def get(key)
    if @head.nxt.key == key
      return @head.nxt.val
    else
    return get_recurse(@head.nxt,key)
    end
  end

  def get_recurse(link,key)
    return nil if link.nil?
    if link.key == key
      return link.val
    else
      get_recurse(link.nxt,key)
    end
  end


  def include?(key)
    !get_recurse(@head,key).nil?

  end


  def insert(key, val)
    a = Link.new(key, val, @head.nxt)
    @head.nxt = a
  end

  def remove(key)
    if @head.nxt != nil || @head.nxt.key == key
      @head.nxt = @head.nxt.nxt
    end

    found_link = remove_recurse(@head, key)
    found_link.nxt = found_link.nxt.nxt

  end

  def remove_recurse(link,key)
    return nil if link.nil?
    if link.nxt.key == key
      return link
    else
      remove_recurse(link.nxt,key)
    end
  end




  def each
    link = @head.nxt
    array = []
    # until link.nxt.nil?
    #   yield(link)
    #   link = link.nxt
    # end
    stupid_rec(link,array)
    array.each do |link|
      yield link
    end
  end

  def stupid_rec(link,array)
    return nil if link.nil?
    stupid_rec(link.nxt,array)
    array = array << link
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
