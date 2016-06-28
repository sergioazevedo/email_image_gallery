require 'spec_helper'

module Resque

end

module EmailConsumer

  describe ScheduleImageToProcess do
    let(:image_path){'/public/images/storage/image-xpto.jpg'}

    describe ".initialize" do
      it "raises Error if file described in image_path not exists" do
        expect do
          ScheduleImageToProcess.new(image_path: image_path)
        end.to raise_error(ImageNotFoundException)
      end
    end

    describe "#execute" do
      before(:each) do
        allow(File).to receive(:exists?).with(image_path).and_return(true)
      end

      subject do
        ScheduleImageToProcess.new(image_path: image_path)
      end

      context "given a up and running Redis server" do
        it "calls Resque.enqueue_to without error" do
          expect(Resque).to receive(:enqueue_to)
            .with(
              ScheduleImageToProcess::QUEUE,
              ScheduleImageToProcess::JOB_CLASS_NAME,
              image_path
            ).once

          subject.execute
        end
      end

      context "given a up stopped Redis server" do
        it "calls Resque.enqueue_to without error" do
          allow(Resque).to receive(:enqueue_to).and_raise(::Errno::ECONNREFUSED)
          expect{ subject.execute }.to raise_error(RedisConnectionException)
        end
      end

    end
  end
end
