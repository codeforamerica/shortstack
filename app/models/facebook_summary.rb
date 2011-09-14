class FacebookSummary < ActiveRecord::Base
  belongs_to :link
  belongs_to :organization

  validates_presence_of :link_id, :organization_id

  @@sortable_columns = ['name', 'org_name', 'category', 'likes'].freeze
  @@sortable_directions = ['asc', 'desc'].freeze

  def self.sortable(column, direction)
    c = case column
        when 'org_name'
          'organizations.name'
        else
          "facebook_summaries.#{column} IS NOT NULL DESC, facebook_summaries." + column
        end

    joins(:organization)
      .joins(:link)
      .order(c + ' ' + direction)
  end

  def self.sortable_columns
    @@sortable_columns
  end

  def self.sortable_directions
    @@sortable_directions
  end

  def self.aspect_columns
    @@aspect_columns
  end

  def get_round(key)
    self[key].to_f.round(2)
  end

  def completely_delete
    puts self.name
    begin
      self.link.destroy
    rescue
      FacebookStat.where(:link_id => link_id).delete_all
      self.delete
    end
  end

  def self.non_gov
    FacebookSummary.where('category NOT LIKE ? AND category NOT IN (?)', '%overnment%', ['Politician', 'Library', 'Museum/art gallery', 'Hospital/clinic', 'Health/medical/pharmacy'])
  end
end
