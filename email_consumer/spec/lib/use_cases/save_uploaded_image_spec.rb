require 'spec_helper'

module EmailConsumer

  describe 'SaveUploadedImage' do
    let(:image_path){'/tmp/var/image-file.jpg'}
    let(:storage_path){'/public/images/storage'}

    describe ".initialize" do
      it "raises Error if file described in image_path not exists" do
        expect do
          SaveUploadedImage.new(
            image_path: image_path,
            storage_path: storage_path
          )
        end.to raise_error(EmailConsumer::ImageNotFoundException)
      end

      it "creates storage folder if folder specifie :storage_path does not exists" do
        allow(File).to receive(:exists?).with(image_path).and_return(true)
        allow(File).to receive(:exists?).with(storage_path).and_return(false)
        expect(FileUtils).to receive(:mkdir_p).with(storage_path)

        SaveUploadedImage.new(
          image_path: image_path,
          storage_path: storage_path
        )
      end
    end

    describe "#execute" do
      it "creates image file at storage_path" do
        allow(File).to receive(:exists?).with(image_path).and_return(true)
        allow(File).to receive(:exists?).with(storage_path).and_return(true)
        expect(FileUtils).to receive(:copy_entry).once
        SaveUploadedImage.new(
          image_path: image_path,
          storage_path: storage_path
        ).execute
      end
    end
  end

end
