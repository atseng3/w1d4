require 'debugger'
def range(start_num, end_num)
  if start_num+1 == end_num
    return []
  else
    range(start_num+1, end_num) << start_num+1
  end
end

def iterative_sum(numbers)
  sum = 0
  numbers.each do |num|
    sum += num
  end
  sum
end

def recursive_sum(numbers)
  return numbers.pop if numbers.length == 1
  numbers.pop + recursive_sum(numbers)
end

def recursive_exp1(base, exp)
  return 1 if exp == 0
  base * recursive_exp1(base, exp-1)
end

def recursive_exp2(base, exp)
  # return 0 if base == 0
  return 1 if exp == 0
  if exp.even?
    recursive_exp2(base, exp/2) ** 2
  else
    base * (recursive_exp2(base, (exp-1)/2) ** 2)
  end

end

def deep_dup(arr)
  return arr unless arr.is_a?(Array)
  dup_arr = []
  arr.each_with_index do |item, index|
    dup_arr << deep_dup(item)
  end
  dup_arr
end

def recur_fibonacci(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  recur_fibonacci(n - 1) << recur_fibonacci(n - 1)[-1] + recur_fibonacci(n - 1)[-2]
  # [].tap do |f_nums|
  #   f_nums <<
  # end
end

def iter_fibonacci(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  [0,1].tap do |fib_arr|
    n.times do
      fib_arr << fib_arr[-1] + fib_arr[-2]
    end
  end
end

def bsearch(array, target)
  array.sort!
  # debugger
  return nil if (array.count == 1 && target != array[0])
  return array.count/2 if array[array.count/2] == target
  return 0 if array[0] == target
  # puts array.count/2
  # debugger
  if array[array.count/2] < target
    amount = bsearch(array[array.count/2..array.count], target)
    return nil if amount.nil?
    # return nil if bsearch(array[array.count/2..array.count], target).nil?
    array.count/2 + amount
  else
    bsearch(array[0..array.count/2-1], target)
  end

end

def make_change(amount, coins = [25, 10, 5, 1])
  # return [25] if amount == 25
  # return [10] if amount == 10
  # return [5] if amount == 5
  return [1] if amount == 1
  wallet = []
  coins.each_with_index do |coin, index|
    if amount > coin
       wallet << coin
       amount -= coin
       return wallet += make_change(amount, coins)

      # wallet += make_change(amount - coin, coins)
      # amount -= coin
      # wallet += make_change(amount)
    end
  end
  wallet
end

def merge_sort(random_arr)
  return random_arr if random_arr.length < 2

  first_half = random_arr[0..random_arr.length/2-1]
  second_half = random_arr[random_arr.length/2..-1]
  merge(merge_sort(first_half), merge_sort(second_half))
  # merge_sort(first_half)
  # merge_sort(second_half)



  # if lenth == 2
#     split
#     comparing
#     stacking
#     return stack
#   else
#     mege sort
end

def merge(first_half, second_half)

  sorted = []
  until first_half.empty? and second_half.empty?
    if first_half.empty?
      sorted << second_half.shift
      next
    end
    if second_half.empty?
      sorted << first_half.shift
      next
    end
    break if first_half.empty? and second_half.empty?
    if first_half[0] < second_half[0]
      sorted << first_half.shift
    elsif first_half[0] > second_half[0]
      sorted << second_half.shift
    end

  end
  sorted
end

if __FILE__ == $PROGRAM_NAME

  #p range(1,10)
  #p recursive_sum([1,2,3])
  # p iterative_sum([1,2,3])
  # p recursive_exp1(4, 3)
  # p recursive_exp2(0, 2)
  # original_arr =[1, [2], [3, [4]]]
  # arr = deep_dup(original_arr)
  # arr[1] << 3
  # p " mod #{arr}"
  # p " original #{original_arr}"
  # p recur_fibonacci(7)
  # p iter_fibonacci(7)
  # p bsearch([0,0,1,2,3,4,5,6,7,8], 80)
  # p bsearch([0,2,3,4], 1)
  # p make_change(27)
  p merge_sort([5,8,7,4,11,14,77,88,3,2,1])
end
