require 'spec_helper'

describe LinksController do
  
  let(:link) { mock_model(Link) }

  describe "GET 'show'" do
    it "assigns @link" do
      Link.should_receive(:find).with(1234).and_return(link)
      #link.stub :id => 1234
      
      get :show, {:id => "16i"} # /links/{}urlcurta}
      assigns[:link].should eq(link)
    end
    
  end
  


  describe "GET 'new'" do
    it "renders new template" do
      get :new
      response.should render_template("new")
    end      
    it "assigns @link" do 
      get :new
      assigns[:link].should be_an(Link)
    end
  end  
  
  describe "POST 'create'" do   
    
     before do
        Link.stub :new => link
     end
     
    
     context "when link is saved" do         
       before do
         link.stub :save => true
       end  
     
       it "create a new link" do
         Link.should_receive(:new).with("url" => "http://www.unesc.net").and_return(link)
         post :create, :link => {:url => "http://www.unesc.net"}
       end
       it "saves link" do 
         link.should_receive(:save)
         post :create
       end
       it "redirects to the show page" do
         post :create
         response.should redirect_to(link_path(link))
       end
       it "displays message" do
         post :create
         flash[:success].should eq("Here's your new shortened url!")
       end
     end  
     
     context "when link is invalid" do
        before do
           link.stub :save => false, 
                     :valid => false, # need to use respond_with
                     :errors => { :anything => "any value (even nil)" }
        end  

        it "renders new template" do
          post :create, :link => {}
          #require "ruby-debug"; debugger; true
          response.should render_template("new")
        end
        it "assigns @link" do
          post :create
          assigns[:link].should eq(link)
        end
     end
     
     describe "GET 'expand'" do
    let(:link) { Factory(:link) }



    it "increases visit counting" do
      get :expand, :shortlink => link.to_param
      link.reload
      link.visits.should == 1
    end
  end
  end

end
