# frozen_string_literal: true

require 'benchmark'

rel = Dir['./tmp/*.rb']

Benchmark.bmbm do |x|
  x.report('require(relative)') { rel.each { |fpath| require fpath } }
end
