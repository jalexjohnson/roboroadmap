class Project < ActiveRecord::Base

  has_many :jobs, dependent: :destroy
  has_many :bidders, dependent: :destroy
  belongs_to :user

  validates_presence_of :name, :user_id, :capacity
  validates_uniqueness_of :name
  validates_numericality_of :capacity, greater_than_or_equal_to: 0
  validates_numericality_of :capacity, less_than_or_equal_to: 1000 #need to place a limit bc knapsack is O(capacity*job_count)

  def bidding_open?
    return self.auction_end.blank? || self.auction_end.future?
  end

  #Inspiration from:
  #http://www.markhneedham.com/blog/2013/01/07/knapsack-problem-python-vs-ruby/
  #https://www.ics.uci.edu/~eppstein/161/python/knapsack.py
  def knapsack
    items = []
    self.jobs.each do |job|
      job.update(fits: false)
      items << job
    end
    items_count = items.count
    capacity = self.capacity
    cache = [].tap { |m| (items_count+1).times { m << Array.new(capacity+1) } }
    cache[0].each_with_index { |value, size| cache[0][size] = 0  }

    (1..items_count).each do |i|
      value = items[i-1].total_value
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
        items[cnt].update(fits: true)
        cap -= items[cnt].size
      end
    end
  end

end
