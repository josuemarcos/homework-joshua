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

  def get_comment(article_id, id)

    article = Article.find_by(id: article_id)
    return {ok: false, msg: 'Article not found'} if article.nil?

    res = Comment.find_by(id: id)
    if res
      { ok: true, data: res }
    else
      { ok: false, msg: 'Comment not found' }
    end
  rescue StandardError => e
    puts "Error fetching article: #{e.message} (#{e.class})"
    { ok: false, msg: e.message }
  end
end