require 'pathname'
require 'securerandom'
require 'fileutils'

module EmailConsumer
  class ImageNotFoundException < Exception; end

  class SaveUploadedImage

    def initialize(image_path:, storage_path:)
      @src_path = Pathname.new(image_path)
      raise_error_if_image_not_exits!
      create_storage_folder_if_not_exists(storage_path)
      @dest_path = Pathname.new("#{storage_path}/#{generate_file_name}")
    end

    def execute
      FileUtils.copy_entry(@src_path.expand_path, @dest_path.expand_path)

      { path: @dest_path }
    end

    private
    def generate_file_name
      "#{SecureRandom.uuid}#{@src_path.extname}"
    end

    def create_storage_folder_if_not_exists(storage_path)
      FileUtils::mkdir_p(storage_path) unless File.exists?(storage_path)
    end

    def raise_error_if_image_not_exits!
      fail ImageNotFoundException unless File.exists?(@src_path.expand_path.to_s)
    end
  end
end
