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

  def get_comment(id)
    res = Comment.find_by(id: id)

    if res
      { ok: true, data: res }
    else
      { ok: false, msg: 'Comment not found' }
    end
  rescue StandardError => e
    puts "Error fetching comment: #{e.message} (#{e.class})"
    { ok: false, msg: e.message }
  end

  def create_comment(comment)
    new_comment = Comment.new(:content => comment['content'], :author_name => comment['author_name'], :created_at => Time.now)
    new_comment.save
    { ok: true, obj: comment }
  rescue StandardError
    { ok: false }
  end

  def update_comment(id, new_data)

    comment = Comment.find_by(id: id)

    return { ok: false, msg: 'Comment could not be found' } if comment.nil?

    comment.content = new_data['content']
    comment.author_name = new_data['author_name']
    comment.save

    return { ok: true, obj: comment }
  rescue StandardError
    { ok: false }
  end

  def delete_comment(id)

    comment = Comment.find_by(id: id)

    return { ok: false, msg: 'Comment could not be found' } if comment.nil?

    comment.delete
    {ok: true}  
  rescue StandardError
    { ok: false }
  end

end