class Article < ActiveRecord::Base 
  has_many :comments
  self.table_name = 'articles'
end
