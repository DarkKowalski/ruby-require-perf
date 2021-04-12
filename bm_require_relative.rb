# frozen_string_literal: true

require 'benchmark'

rel = Dir['./tmp/*.rb']

Benchmark.bmbm do |x|
  x.report('require_relative ') { rel.each { |fpath| require_relative fpath } }
end
