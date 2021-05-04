class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # �o���f�[�V���� 
  before_save { self.email = email.downcase }
  validates :email,     {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}
  validates :password,  {length: { in: 8..32 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]/}}
  with_options presence: true do
    validates :last_name
    validates :first_name
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Confirm���[���L�������̃`�F�b�N
  def is_confirmation_period_expired?
    self.confirmation_period_expired?
  end
end
