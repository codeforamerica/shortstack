class Relationship < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
  belongs_to :product
  scope :role, lambda {|name| {:conditions => ["relationships.relation_type = ?", name]}}   
  
  def related_to(owner)
    case owner
    when "person"
      if organization.nil?
        product
      else
        organization
      end
    when "organization"
      if person.nil?
        product
      else
        person
      end
    when "product"
      if organization.nil?
        person
      else
        organization
      end
    end
  end 
  
  private
  
  def return_organization
    organization
  end
  
  def return_person
    person
  end
  
  def return_product
    product
  end   
end
