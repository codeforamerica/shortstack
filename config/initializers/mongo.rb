
MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "mongo_test_#{Rails.env}"

MongoMapper.config = {
 Rails.env => { 'uri' => ENV['MONGOHQ_URL'] ||
                         'mongodb://localhost/shortstack' } }
MongoMapper.connect(Rails.env)
