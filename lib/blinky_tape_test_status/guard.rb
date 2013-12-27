#!/usr/bin/env ruby
require 'blinky_tape_test_status'

module BlinkyTapeTestStatus
  class Guard < BlinkyTapeTestStatus::Base
    VERSION = '0.0.2'
    
    COLORS = {
      'success' => 'g',
      'failed'  => 'r',
      'pending' => 'y',
    }

    def initialize(options={})
      @filename = options[:filename]
      super options
    end

    def set_status!
      solid!
      color! test_status_color
    end

    protected
    def test_status_color
      COLORS[line] || 'w'
    end

    def line
      File.open(@filename, &:readline).strip
    end
  end
end
