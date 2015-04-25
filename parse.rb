def parse_name(line)
  parts = line.split
  parts.size == 6 ? parts.last : ""
end

def parse_mem(line)
  parts = line.split
  parts.size > 2 ? parts[1].to_i : 0
end

procs = [{}]
i = 0
new_line = true

File.readlines('smaps.txt').each do |line|
  if line.start_with?("VmFlags")
    i += 1
    new_line = true
    procs << {}
  else
    if new_line
      procs[i][:name] = parse_name(line)
    elsif line.start_with?("Size:")
      procs[i][:size] = parse_mem(line)
    elsif line.start_with?("Rss:")
      procs[i][:rss] = parse_mem(line)
    end
    new_line = false
  end
end

procs.pop

jvm_heap = procs.select{|proc| proc[:size] == 260608 and proc[:name].empty? }

tot_kb = procs.inject(0) do |sum, proc|
  sum + proc[:rss]
end

#tot_kb_non_app = procs.inject(0) do |sum, proc|
  #sum + (proc[:name].empty? ? proc[:rss] : 0)
#end

tot_kb_lib = procs.inject(0) do |sum, proc|
  sum + ((proc[:name].start_with?("/lib") or proc[:name].include?(".jdk")) ? proc[:rss] : 0)
end

tot_kb_heap = procs.inject(0) do |sum, proc|
  sum + (proc[:name].start_with?("[heap") ? proc[:rss] : 0)
end

buffers = procs.select {|proc| proc[:name].empty? and proc[:rss] > 500 }

stacks = procs.select{|proc| proc[:name].start_with?("[stack") }

threads = procs.select{|proc| proc[:size] == 504 and proc[:name].empty? }

jvm_heap_kb = jvm_heap.inject(0){|sum, p| sum + p[:rss]}
stack_kb = stacks.inject(0){|sum, p| sum + p[:rss]}
thread_kb = threads.inject(0){|sum, p| sum + p[:rss]}
buffer_kb = buffers.inject(0){|sum, p| sum + p[:rss]} - jvm_heap_kb

puts "[heap]   kB: #{tot_kb_heap}"
puts "[stack]  kB: #{stack_kb} / #{stacks.size}"
puts "threads  kB: #{thread_kb} / #{threads.size}"
puts "libs     kB: #{tot_kb_lib}"
puts "buffers  kB: #{buffer_kb} / #{buffers.size}"
puts "JVM Heap kB: #{jvm_heap_kb}"
puts "KNOWN    kB: #{jvm_heap_kb + tot_kb_heap + thread_kb + tot_kb_lib}"

puts "Total    kB: #{tot_kb}"
