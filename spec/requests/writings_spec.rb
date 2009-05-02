require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a writing exists" do
  Writing.all.destroy!
  request(resource(:writings), :method => "POST", 
    :params => { :writing => { :id => nil }})
end

describe "resource(:writings)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:writings))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of writings" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a writing exists" do
    before(:each) do
      @response = request(resource(:writings))
    end
    
    it "has a list of writings" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Writing.all.destroy!
      @response = request(resource(:writings), :method => "POST", 
        :params => { :writing => { :id => nil }})
    end
    
    it "redirects to resource(:writings)" do
      @response.should redirect_to(resource(Writing.first), :message => {:notice => "writing was successfully created"})
    end
    
  end
end

describe "resource(@writing)" do 
  describe "a successful DELETE", :given => "a writing exists" do
     before(:each) do
       @response = request(resource(Writing.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:writings))
     end

   end
end

describe "resource(:writings, :new)" do
  before(:each) do
    @response = request(resource(:writings, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@writing, :edit)", :given => "a writing exists" do
  before(:each) do
    @response = request(resource(Writing.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@writing)", :given => "a writing exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Writing.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @writing = Writing.first
      @response = request(resource(@writing), :method => "PUT", 
        :params => { :writing => {:id => @writing.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@writing))
    end
  end
  
end

