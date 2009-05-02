require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a commentse exists" do
  Commentse.all.destroy!
  request(resource(:commentses), :method => "POST", 
    :params => { :commentse => { :id => nil }})
end

describe "resource(:commentses)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:commentses))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of commentses" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a commentse exists" do
    before(:each) do
      @response = request(resource(:commentses))
    end
    
    it "has a list of commentses" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Commentse.all.destroy!
      @response = request(resource(:commentses), :method => "POST", 
        :params => { :commentse => { :id => nil }})
    end
    
    it "redirects to resource(:commentses)" do
      @response.should redirect_to(resource(Commentse.first), :message => {:notice => "commentse was successfully created"})
    end
    
  end
end

describe "resource(@commentse)" do 
  describe "a successful DELETE", :given => "a commentse exists" do
     before(:each) do
       @response = request(resource(Commentse.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:commentses))
     end

   end
end

describe "resource(:commentses, :new)" do
  before(:each) do
    @response = request(resource(:commentses, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@commentse, :edit)", :given => "a commentse exists" do
  before(:each) do
    @response = request(resource(Commentse.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@commentse)", :given => "a commentse exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Commentse.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @commentse = Commentse.first
      @response = request(resource(@commentse), :method => "PUT", 
        :params => { :commentse => {:id => @commentse.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@commentse))
    end
  end
  
end

