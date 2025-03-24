class ArticleController
  def create_article(article)
    article_not_exists = (Article.where(:title => article['title']).empty?)

    return { ok: false, msg: 'Article with given title already exists' } unless article_not_exists

    new_article = Article.new(:title => article['title'], :content => article['content'], :created_at => Time.now)
    new_article.save

    { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)

    article = Article.where(id: id).first

    return { ok: false, msg: 'Article could not be found' } if article.nil?

    article.title = new_data['title']
    article.content = new_data['content']
    article.save

    return { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def get_article(id)
    res = Article.find_by(id: id)
  
    if res
      { ok: true, data: res }
    else
      { ok: false, msg: 'Article not found' }
    end
  rescue StandardError => e
    puts "Error fetching article: #{e.message} (#{e.class})"
    { ok: false, msg: e.message }
  end

  def delete_article(id)
    article = Article.where(id: id).first
    if article.nil?
      return { ok: false, msg: 'Article not found' }
    else
      article.delete
      delete_count =  1
      { ok: true, delete_count: delete_count }
    end
  end

  def get_batch

    res = Article.all

    if res.empty?
      { ok: false, msg: 'Article not found' }
    else
      { ok: true, data: res }
    end
  rescue StandardError
    { ok: false }
    
  end
end
