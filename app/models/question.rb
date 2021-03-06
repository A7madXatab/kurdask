class Question < ApplicationRecord
  include Votable, Viewable

  belongs_to :user
  has_many :comments
  has_many :answers

  validates :description, presence: true
  validates :title, presence: true

  before_save do
    self.title = title.split(" ").join("-").downcase.split(".").join("");
  end

  scope :where_title_like, ->(name) { where('title Like ?', "%#{name}%") }

  def to_param
    title
  end

  def formatted_title
    title.split("-").join(" ");
  end

  def count_answers
    answers.count
  end

  def owner?(user)
    user_id == user.id
  end
end
