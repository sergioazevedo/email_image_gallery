require 'pathname'
require 'securerandom'

module EmailConsumer
  class SaveUploadedImage

    def initialize(image_path:, storage_path: "public/images/upload/")
      @src_path = Pathname.new(image_src_path)
      @dest_path = Pathname.new("#{uploaded_src_path}/#{generate_file_name}")
    end

    def execute
      FileUtils.copy_entry(@src_path, @dest_path)

      { path: @dest_path }
    end

    private
    def generate_file_name
      "#{SecureRandom.uuid}#{@image_src_path.extname}"
    end
  end
end
