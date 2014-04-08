require 'blinky_cloud'
require 'thread'

module BlinkyTapeTestStatus
  module GuardCloud

    def listen_for_cloud!
      @semaphore = Mutex.new
      listener = BlinkyCloud::Listener.new
      @listen_thread = Thread.new {
        loop do
          listener.listen(lambda { |data| thread_write! data })
        end
      }
    end

    def thread_write!(data)
      @semaphore.synchronize {
        write! data
      }
    end
  end
end
