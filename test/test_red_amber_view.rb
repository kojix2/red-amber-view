# frozen_string_literal: true

require_relative 'test_helper'

class RedAmberViewTest < Test::Unit::TestCase
  test 'it_has_a_version_number' do
    assert_kind_of String, RedAmber::View::VERSION
  end
end
