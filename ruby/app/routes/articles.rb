require_relative '../controllers/articles'

class ArticleRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @articleCtrl = ArticleController.new
  end

  before do
    content_type :json
  end

  get('/') do 
    summary = @articleCtrl.get_batch #TODO: Understand get_batch

    if !(summary[:ok]) #TODO: Verify logic
      { articles: summary[:data] }.to_json
    else
      { msg: 'Could not get articles.' }.to_json
    end
  end

  get('/:id') do #TODO: No content in the action
    
  end

  post('/') do
    payload = JSON.parse(request.body.read) #TODO: Verify if it is possible to use params
    summary = @articleCtrl.update_article(payload)

    if summary[:ok]
      { msg: 'Article updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:id') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.uptade_article params['ids'], payload

    if summary[:ok]
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:id') do
    summary = self.delete_article params['id']

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { mgs: 'Article does not exist' }.to_bson
    end
  end
end
