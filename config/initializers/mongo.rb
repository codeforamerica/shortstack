MongoMapper.config = {
 Rails.env => { 'uri' => ENV['MONGOHQ_URL'] ||
                         'mongodb://localhost/shortstack' } }
MongoMapper.connect(Rails.env)
