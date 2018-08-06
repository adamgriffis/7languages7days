module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  class CsvRow
    attr_accessor :headers, :row_contents

    def initialize(headers, row_contents)
      @headers = headers
      @row_contents = row_contents
    end

    def method_missing name, *args
      header_index = @headers.find_index(name.to_s)

      raise "No method defined #{name}" if header_index.nil?

      @row_contents[header_index]
    end
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @rows = []
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        row_array = row.chomp.split(', ')
        @csv_contents << row_array
        @rows << ActsAsCsv::CsvRow.new(@headers, row_array)
      end
    end

    def each
      @rows.each do |row|
        yield row
      end
    end

    attr_accessor :headers, :csv_contents, :rows
    def initialize
      read
    end
  end
end


class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect

m.each {|row| puts row.description }