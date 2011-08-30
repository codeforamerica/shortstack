# Extends product with json or xml output for Portable Application Description specification
# http://pad.asp-software.org/spec/spec.php

class PadSpecification
  
  def initialize(product)
    @product = product
  end
  
  def produce
    content = {
    "PAD Information" => pad_information,
    "Company Information" => company_information,
    "Program Information" => program_information,
    "Program Description" => program_description,
    "Web Information" => web_information,
    "Permission Information" => permission_information
    }
  end
  
  def pad_information(version="3.11", editor="shortstack", comment="http://pad.asp-software.org/spec/spec.php")
    content = {"PAD Version" => version, "PAD Editor" => editor, "PAD Comment" => comment}
  end
  
  def company_information
    content = {}
    company = @product.organization
    if !company.nil?
      content["Company name"] = company.name
      if !company.addresses.blank?
        content["Address"] = company.addresses.first.address
        content["City or town"] = company.addresses.first.city
        content["State"]= company.addresses.first.state
        content["Zip"] = company.addresses.first.zipcode
        content["Country"] = company.addresses.first.country
      end
      content["Website"] = company.links.website.first.link_url unless company.links.website.blank?
      if !company.contacts.blank?
        content["General email"] = company.contacts.first.email unless company.contacts.first.email.blank?
        content["General phone"] = company.contacts.first.phone unless company.contacts.first.phone.blank?
      end
    end
    content
  end
  
  def program_information
    content = {}
    content["Name"] = @product.name
    content["Requirements"] = @product.notes.requirements.first.note unless @product.notes.requirements.blank?
    content
  end
  
  def program_description
    content = {}    
    content["Keywords"] = @product.tag_list unless @product.tag_list.blank?
    content["2000 character description"] = @product.notes.about.first.note unless @product.notes.about.blank?
    content
  end
  
  def web_information
    content = {}    
    content["Application info URL"] = @product.links.website.first.link_url unless @product.links.website.blank?
    content    
  end
  
  def permission_information
    content = {}    
    content["Distribution permissions"] = @product.notes.permission.first.note unless @product.notes.permission.blank?
    content["EULA"] = @product.notes.eula.first.note unless @product.notes.eula.blank?
    content
  end

  
end