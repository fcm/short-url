class Link < ActiveRecord::Base

   validates :url,
             :presence => true,
             :format => { :with => %r[^https?://]i, :on => :create }

end