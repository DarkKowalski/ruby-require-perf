#!/usr/bin/env ruby
# frozen_string_literal: true

bm = Dir['./bm_*.rb']
bm.each { |b| Process.fork { puts `ruby #{b} && echo` } }
Process.waitall
