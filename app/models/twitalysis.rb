module Twitalysis
  class Cached
    def initialize(handle)
      @db = CouchRest.database!(@db_name)
      @method = self.class.name.split('::').last.downcase.to_sym
      @handle = handle

      @doc = nil
    end

    def get
      @doc = begin
        get_from_couch
      rescue RestClient::ResourceNotFound
        get_from_twitter
      end
    end

    def get_from_couch
      @db.get(@handle)
    end

    def get_from_twitter
      Twitter.__send__(@method, @handle)
    end

    def cache
      CouchRest.put "#{@db.root}/#{@handle}", @doc
    end

    class << self
      def from_link(link)
        self.new(Twitalysis.link_to_handle(link))
      end
    end
  end

  class User < Cached
    def initialize(*args)
      @db_name = 'twitters'
      super *args
    end
  end
  


  # module methods
  def self.link_to_handle(link)
    link.match(Twitter::Regex::REGEXEN[:valid_url])[6].split('/')[1]
  end
end
