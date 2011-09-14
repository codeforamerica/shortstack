require 'spec_helper'

describe PadSpecification do
  before do
    @product = Factory(:product)
  end

  context 'produces hashes for' do
    it 'pad_information' do
      PadSpecification.new(@product).pad_information.should == {"PAD Version"=>"3.11", "PAD Editor"=>"shortstack", "PAD Comment"=>"http://pad.asp-software.org/spec/spec.php"}
    end

    it 'company_information' do
      @company = Factory(:company)
      @company.products << @product
      PadSpecification.new(@product).company_information.should == {"Company name"=>@company.name, "Address"=>@company.addresses.first.address, "City or town"=>@company.addresses.first.city, "State"=>@company.addresses.first.state, "Zip"=>@company.addresses.first.zipcode, "Country"=>@company.addresses.first.country, "Website"=>@company.links.website.first.link_url, "General email"=>@company.contacts.first.email, "General phone"=>@company.contacts.first.phone}
    end

    it 'program_information' do
      @company = Factory(:company)
      @company.products << @product
      PadSpecification.new(@product).program_information.should == {"Name"=>@product.name, "Requirements"=>@product.notes.requirements.first.note}
    end

    it 'program_description' do
      PadSpecification.new(@product).program_description.should == {"Keywords"=>@product.tag_list, "2000 character description"=>@product.notes.about.first.note}
    end

    it 'web_information' do
      PadSpecification.new(@product).web_information.should == {"Application info URL"=>@product.links.website.first.link_url}
    end

    it 'permission_information' do
      PadSpecification.new(@product).permission_information.should == {"Distribution permissions"=>"text", "EULA"=>"text"}
    end

    it 'produces' do
      pad = PadSpecification.new(@product).produce
      pad.size.should == 6
    end

  end
end
