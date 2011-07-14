MongoMapper.config = {
 Rails.env => { 'uri' => ENV['MONGOHQ_URL'] ||
                         'mongodb://localhost:27017/short-stack' } }
MongoMapper.connect(Rails.env)
