require 'pathname'
require 'benchmark'

rel = Dir['./tmp/*.rb']
abs = rel.map { |fpath| Pathname.new(fpath).realpath }

compiled_rel = Dir['./tmp/*.rbc']
compiled_abs = compiled_rel.map { |fpath| Pathname.new(fpath).realpath }

Benchmark.bmbm do |x|
  x.report('require-absolute') { abs.each { |fpath| require fpath } }
  x.report('require-relative') { rel.each { |fpath| require fpath } }

  x.report('require-absolute-compiled') do
    compiled_abs.each { |fpath| RubyVM::InstructionSequence.load_from_binary(File.read(fpath)) }
  end

  x.report('require-relative-compiled') do
    compiled_rel.each { |fpath| RubyVM::InstructionSequence.load_from_binary(File.read(fpath)) }
  end
end
