class AddMarkdownToPost < ActiveRecord::Migration
  def change
    add_column :posts, :markdown, :string
  end
end
