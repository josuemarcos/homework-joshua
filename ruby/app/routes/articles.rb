require_relative '../controllers/articles'
require_relative '../controllers/comments'
require_relative '../middleware/auth'
require 'sinatra'

class ArticleRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @articleCtrl = ArticleController.new
    @commentCtrl = CommentController.new
  end

  before do
    content_type :json
  end

  get('/') do
    summary = @articleCtrl.get_batch

    if (summary[:ok])
      status 200
      { articles: summary[:data] }.to_json
    else
      status 404
      { msg: 'Could not get articles.' }.to_json
    end
  end

  get('/:id') do
    summary = @articleCtrl.get_article(params[:id])

    if (summary[:ok])
      status 200
      { article: summary[:data] }.to_json
    else
      status 200
      { msg: 'Could not get articles.' }.to_json
    end
  end

  post('/') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.create_article(payload)

    if summary[:ok]
      status 200
      { msg: 'Article created' }.to_json
    else
      status 422
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:id') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.update_article(params[:id], payload)

    if summary[:ok]
      { msg: 'Article updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:id') do
    summary = @articleCtrl.delete_article(params[:id])

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { msg: 'Article does not exist' }.to_json
    end
  end

  get('/:article_id/comments') do
    summary = @commentCtrl.get_batch(params[:article_id])

    if (summary[:ok])
      status 200
      { comments: summary[:data] }.to_json
    else
      status 404
      { msg: summary[:msg] }.to_json
    end
  end

  get('/:article_id/comments/:id') do
    summary = @commentCtrl.get_comment(params[:article_id], params[:id])

    if (summary[:ok])
      status 200
      { comment: summary[:data] }.to_json
    else
      status 200
      { msg: 'Could not find the comment!.' }.to_json
    end
  end

  post('/:article_id/comments') do
    payload = JSON.parse(request.body.read)
    summary = @commentCtrl.create_comment(payload)

    if summary[:ok]
      status 201
      { msg: 'Comment created' }.to_json
    else
      status 422
      { msg: summary[:msg] }.to_json
    end
  end

  put ('/:article_id/comments/:id') do
    payload = JSON.parse(request.body.read)
    summary = @commentCtrl.update_comment(params[:id], payload)

    if summary[:ok]
      { msg: 'Comment updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end
end
