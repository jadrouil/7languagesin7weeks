module ActAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def  read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')
      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

      attr_accessor :headers, :csv_contents
      def initialize
        read
      end
    end
  end


class TestCsv
  include ActAsCsv
  acts_as_csv
end

m = TestCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect

class CsvRow
  attr_accessor :headers, :content
  def initialize(headers, rowcontent)
    @headers = headers
    @content= {}
    colNum = 0
    headers.each do |header|
      @content[header] = rowcontent[colNum]
      colNum += 1
    end
  end
end

class CsvRow
  def method_missing name, *args
    element = name.to_s
    @content[element]
  end
end


puts "testing row construction"
a = CsvRow.new ["sport", 'detroit', 'chicago'], ['football', 'lions', 'bears']
puts a.sport
puts a.detroit
puts a.chicago

module ActAsCsv
  module InstanceMethods
    def each &block
      @csv_contents.each do |row|
        a = CsvRow.new(@headers, row)
        block.call a
      end
    end
  end
end

puts "testing each method for Csv module"
n = TestCsv.new
n.each do |row|
  puts row.sport, row.detroit, row.chicago
end
puts "done testing"
