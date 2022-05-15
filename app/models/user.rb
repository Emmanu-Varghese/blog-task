class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  scope :admin, -> { where(admin: true) }

  devise :database_authenticatable, :registerable, :rememberable, :validatable
  attr_readonly :email
  validates :name, presence: true

  has_person_name

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :emotes, dependent: :destroy
end
