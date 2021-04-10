require 'fileutils'

class FileTemplate
  attr_reader :str

  def initialize(line_num: 1)
    @str = String.new
    @str << "def temp\n"
    line_num.times { |n| @str << ("puts '#{n}'\n") }
    @str << "end\n"
  end
end

class FileGenerator
  def self.generate(file_num: 100, line_num: 200)
    file_num.times do |fnum|
      File.open("./tmp/temp_file_#{fnum}.rb", 'w') do |f|
        f.puts FileTemplate.new(line_num: line_num).str
      end
    end
  end
end

class Compiler
  def self.compile(src, dst)
    bin = RubyVM::InstructionSequence.compile(File.read(src), src, src).to_binary
    File.open(dst, 'wb') do |f|
      f.write(bin)
    end
  end

  def self.compile_tmp
    source = Dir["./tmp/**/*.rb"]
    source.each do |src|
      dst = "#{src}.rbc"
      Compiler.compile(src, dst)
    end
  end
end

FileUtils.rm_rf './tmp'
FileUtils.mkdir_p './tmp'

# Ruby 3.0.1 amd64
# Change this, then `ruby prepare.rb && ruby benchmark.rb`
FileGenerator.generate(file_num: 10000, line_num: 10_000)

Compiler.compile_tmp
