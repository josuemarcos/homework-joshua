class CommentController
  def get_batch(article_id)

    article = Article.find_by(id: article_id)

    return {ok: false, msg: 'Article not found'} if article.nil?

    res = Comment.where(article_id: article_id )

    if res.empty?
      { ok: false, msg: 'This article has no comments!' }
    else
      { ok: true, data: res }
    end
  rescue StandardError
    { ok: false }
    
  end
end