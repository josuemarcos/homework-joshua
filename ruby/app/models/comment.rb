class Comment < ActiveRecord::Base 
  belongs_to :article
  self.table_name = 'comments'
end