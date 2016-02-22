class User < ActiveRecord::Base
  has_secure_password
  has_many :documents, foreign_key: 'uploader_id'
  has_many :comments
  has_many :likes
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 25
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 25
  validates_presence_of :username
  validates_length_of :username, :within => 3..25
  validates_uniqueness_of :username
  validates_length_of :first_name, :maximum => 25
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_length_of :email, :maximum => 100
  validates_format_of :email, :with => EMAIL_REGEX
  validates_confirmation_of :email
  validate :birth_date_is_valid

  before_destroy :delete_user_documents, :delete_user_comments
  before_create { generate_token(:auth_token) }

  def birth_date_is_valid
    if age < 4 || age > 120
      errors.add(:birth_date, "is invalid.\nPlease enter your real birth date.")
    end
  end

  def age
    Date.today.year - birth_date.year
  end

  def name
    "#{first_name} #{last_name}"
  end

  private

  def delete_user_documents
    self.documents.destroy_all
  end

  def delete_user_comments
    self.comments.destroy_all
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
end
