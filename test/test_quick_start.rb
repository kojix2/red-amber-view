# frozen_string_literal: true

require_relative 'test_helper'

class QuickStartTest < Test::Unit::TestCase
  test 'it run quick start' do
    require 'red_amber/view'
    require 'datasets-arrow'

    arrow = Datasets::Penguins.new.to_arrow
    penguins = RedAmber::DataFrame.new(arrow)
    pid = penguins.view
    thr = Process.detach(pid)
    sleep 2.5
    assert_true thr.alive?
    Process.kill(:KILL, pid)
  end
end
