module EmailConsumer

  class ScheduleImageToProcess

    QUEUE = :image_process
    JOB_CLASS_NAME = 'ImageProcessJob'

    def initialize(image_path:)
      fail ImageNotFoundException unless File.exists?(image_path)
      @image_path = image_path
    end

    def execute
      Resque.enqueue_to(QUEUE, JOB_CLASS_NAME, @image_path)
    rescue ::Errno::ECONNREFUSED => e
      fail RedisConnectionException, e.message
    end

  end

end
