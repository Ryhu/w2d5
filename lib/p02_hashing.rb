class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    hash = ""
    self.each do |el|
      hash << el.to_s
    end
    return hash.to_i
  end
end

class String
  def hash
    self.split("").map(&:ord).hash
  end
end

class Hash
  def hash
    hash_array = []

    self.sort.each do |key, value|
      if key.is_a?(Symbol)
        hash_array << key.to_s + "s"
        hash_array << value.hash
      else
        hash_array << key.hash
        hash_array << value.hash
      end
    end

    hash_array.join.hash
  end
end
