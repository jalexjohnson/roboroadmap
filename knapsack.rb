Item = Struct.new(:name, :size, :value)

example_items = [
  Item.new('A',3,3),
  Item.new('B',4,1),
  Item.new('C',8,3),
  Item.new('D',10,4),
  Item.new('E',15,3),
  Item.new('F',20,6)]

example_capacity = 32

#http://www.markhneedham.com/blog/2013/01/07/knapsack-problem-python-vs-ruby/
#https://www.ics.uci.edu/~eppstein/161/python/knapsack.py
def knapsack(items, capacity)
  items_count = items.count
  cache = [].tap { |m| (items_count+1).times { m << Array.new(capacity+1) } }
  cache[0].each_with_index { |value, size| cache[0][size] = 0  }

  (1..items_count).each do |i|
    value = items[i-1].value
    size = items[i-1].size
    (0..capacity).each do |x|
      if size > x
        cache[i][x] = cache[i-1][x]
      else
        cache[i][x] = [cache[i-1][x], cache[i-1][x-size] + value].max
      end
    end
  end
  #return cache[items_count][capacity] #max_value
  cnt = items_count
  cap = capacity
  while cnt > 0
    if cache[cnt][cap] == cache[cnt-1][cap]
      cnt -= 1
    else
      cnt -= 1
      puts items[cnt].name
      cap -= items[cnt].size
    end
  end
end
