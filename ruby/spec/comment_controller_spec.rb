require 'rspec/autorun'
require 'dotenv'
require_relative '../app/controllers/comments'


# Since /:article_id/comments is a sub-route of articles, it was correctly
# mapped inside ArticleRoutes. Therefore, the route tests couldn't be implemented without
# modifying the given unit tests (routes_spec.rb), which is against the constraints.


describe CommentController do
  let(:controller) {CommentController.new}

  before(:all) do
    require_relative '../config/environment'
    require_relative '../app/models/db_init' # initializes the database schema; uses ENV credentials
  end

  it 'gets all comments from an article' do
    result = controller.get_batch(1)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(3)
  end

  it 'gets an comment from db' do
    result = controller.get_comment(1, 1)
    expect(result).to have_key(:ok)
    expect(result).to have_key(:data)
    expect(result[:ok]).to be true
    expect(result[:data]).to be_truthy
    expect(result[:data][:content]).to eq('Nice Article!')
  end


end