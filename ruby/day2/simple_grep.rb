folder = ARGV[0]
phrase = ARGV[1]

files = Dir.entries(folder)

regex = Regexp.new(".*#{phrase}.*")

files.each do |file_path|
  next if File.directory? file_path

  File.open(file_path, "r") do |f|
    line_num = 0

    f.each_line do |line|
      line_num += 1
      
      puts "#{file_path} - line #{line_num}: #{line}" if regex.match(line)
    end
  end
end
  