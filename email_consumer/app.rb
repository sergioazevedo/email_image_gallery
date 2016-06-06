require_relative './config/environment'
require_relative './lib/email_consumer'

Cuba.define do
  on post do
    on "email" do
      on root do
        qtd = req['attachment-count'].to_i || 0
        qtd.times do |index|
          attachment = req["attachment-#{index + 1}"]
          if attachment[:type].match("image")
            savedImage = EmailConsumer::SaveUploadedImage.new(
              image_path: attachment[:tempfile].path,
              storage_path: 'public/images/upload'
            ).execute
            EmailConsumer::ScheduleImageToProcess.new(image_path: savedImage[:path]).execute
          end
        end
        res.write "OK"
      end
    end
  end
end
