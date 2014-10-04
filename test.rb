require 'parallel'

q = Queue.new

(0..10).to_a.each{|e| q.push(e)}
b = (1..4).to_a
Parallel.map(b, :in_processes => 10){|executor|
  until(q.empty?)
  puts q.pop
  end
}