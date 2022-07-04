# frozen_string_literal: true

require_relative 'test_helper'

class QuickStartTest < Test::Unit::TestCase
  test 'it run quick start' do
    require 'red_amber/view'
    require 'datasets-arrow'

    arrow = Datasets::Penguins.new.to_arrow
    penguins = RedAmber::DataFrame.new(arrow)
    pid = penguins.view
    sleep 3
    Process.kill(:KILL, pid)
  end
end
