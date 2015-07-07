class Post < ActiveRecord::Base
  require 'redcarpet'

  before_update {
    self.markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, :space_after_headers => true, :autolink => true, :strikethrough => true, :superscript => true).render(text)
  }

  validates :title, presence: true, length: {minimum: 5}
  #if your post is under 10 characters, it isn't worth posting.
  validates :text, presence: true, length: {minimum: 10}

  def self.get_posts
    Rails.cache.fetch("posts", :expires_in => 2.minutes) do
      Post.all.reverse_order
    end
  end
end
