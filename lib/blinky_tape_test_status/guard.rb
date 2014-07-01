require 'blinky_tape_test_status'

module BlinkyTapeTestStatus
  class Guard < BlinkyTapeTestStatus::Base
    VERSION = '1.1.2'

    COLORS = {
      'success' => 'g',
      'failed'  => 'r',
      'pending' => 'y',
    }

    def initialize(options={})
      super options
      @filename = options[:filename]
      if options.delete(:cloud)
        require 'blinky_tape_test_status/guard_cloud'
        extend GuardCloud
        listen_for_cloud!
      end
    rescue Exception => e
      puts e.message
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
      File.open(@filename, &:readline).strip if @filename && File.exist?(@filename)
    end
  end
end
