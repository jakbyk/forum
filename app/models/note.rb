# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  include Visible
  include RichTextBody

  belongs_to :user

  has_rich_text :body

  validates :title, presence: true
  validates :title, length: { minimum: 5, maximum: 2000 }, allow_blank: false
end
