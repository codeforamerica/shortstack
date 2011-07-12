MongoMapper.config = {
 Rails.env => { 'uri' => ENV['MONGOHQ_URL'] ||
                         'mongodb://localhost:27017/shortstack' } }
MongoMapper.connect(Rails.env)
