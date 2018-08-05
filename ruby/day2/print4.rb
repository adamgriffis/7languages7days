arr = (1..16).to_a

count = -1
str = ""
arr.each do |num|
  if count < 3 
    count += 1
  else
    puts str
    count = 0
    str = ""
  end

  str += "#{num} "
end
puts str

arr.each_slice(4) do |slice|
  puts slice.join(' ')
end