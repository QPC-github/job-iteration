# frozen_string_literal: true

class IterationJob < ActiveJob::Base
  include JobIteration::Iteration

  def build_enumerator(cursor:)
    enumerator_builder.times(4, cursor: cursor)
  end

  def each_iteration(omg)
    puts "adapter: #{JobIteration.interruption_adapter}"
    if omg == 0 || omg == 2
      Process.kill("TERM", Process.pid)
    end
    sleep 1
  end
end

class TerminateJob < ActiveJob::Base
  def perform
    Process.kill("TERM", Process.pid)
  end
end