require 'debugger'
class Array

  def my_each(&code)
    i = 0
    # debugger
    while i < self.count
      code.call(self[i])
      i += 1
    end
    self
  end

  def my_map(&code)
    my_array = self.dup
    i = 0
    while i < my_array.count
      my_array[i] = code.call(my_array[i])
      i += 1
    end
    my_array
  end

  def my_select(&code)
    my_array = []
    self.my_each do |item|
      my_array << item if code.call(item)
    end
    my_array
  end

  def my_inject(&code)
    value = self[0]
    self.each_with_index do |item, index|
      next if index == 0
      value = code.call(value, item)
    end
    value
  end

  def my_sort!(&code)
    not_sorted = true
    while not_sorted
      not_sorted = false
      (0...self.count-1).each do |index|
        if code.call(self[index], self[index+1]) == 1
          not_sorted = true
          self[index], self[index+1] = self[index+1], self[index]
        end
      end
    end
    self
  end

end

def block_caller(*args, &code)
  return "NO BLOCK GIVEN!" unless block_given?
  code.call(*args)
end

if __FILE__ == $PROGRAM_NAME
  arr = [8,1,2,7,3,4,5]

  p block_caller(1,2,3,4) {|a, b, c, d| a+b+c+d}
  p block_caller(1,2,3,4)
end
