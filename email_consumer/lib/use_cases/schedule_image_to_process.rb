module EmailConsumer

  class ScheduleImageToProcess

    QUEUE = :image_process

    def initialize(image_path:)
      @image_path = image_path
    end

    def execute
      Resque.enqueue_to(QUEUE, 'ImageProcessJob', @image_path)
    end

  end

end
