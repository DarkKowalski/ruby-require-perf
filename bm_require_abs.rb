# frozen_string_literal: true

require 'benchmark'

rel = Dir['./tmp/*.rb']
abs = rel.map { |fpath| File.expand_path(fpath) }

Benchmark.bmbm do |x|
  x.report('require(absolute)') { abs.each { |fpath| require fpath } }
end
