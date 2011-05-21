require "spec_helper"

describe "Visit shortened url" do
  before do
    link = Factory(:link, :url => "http://simplesideias.com.br")
    visit "/#{link.to_param}"
  end

  it "redirects to original link" 
  # do
  #  response.should redirect_to("http://simplesideias.com.br")
  # end
end
