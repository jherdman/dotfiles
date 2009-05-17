IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:USE_READLINE]  = true
IRB.conf[:LOAD_MODULES]  = [] unless IRB.conf.key?(:LOAD_MODULES)
unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
  IRB.conf[:LOAD_MODULES] << 'irb/completion'
end

def quick(repititions=100)
  require 'benchmark'
  Benchmark.bmbm do |b|
    b.report { repititions.times { yield } }
  end
  nil
end
