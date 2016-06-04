Cuba.define do
  on post do
    on "email" do
      on root do
        data = req.body.read
        puts data
        res.write data
      end
    end
  end
end
