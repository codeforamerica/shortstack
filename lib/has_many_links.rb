module HasManyLinks
  def self.included(base)
    base.class_eval do
      has_many :links, :as => :linkable, :class_name => "Link", :dependent => :destroy
      accepts_nested_attributes_for :links

      def has_twitter_link?
        twitter_links.count > 0
      end

      def twitter_links
        link_type = LinkType.find_by_name('Twitter').id
        links.where(:link_type_id => link_type)
      end
    end
  end
end
