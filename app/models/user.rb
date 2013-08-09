class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :profile_name
  # attr_accessible :title, :body

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :profile_name, presence: true,
                            uniqueness: true, 
                            format: {
                              with: /^[a-zA-Z0-9_-]+$/,
                              message: "must be formatted correctly."
                            }

  has_many :statuses

  def full_name
  		first_name + " " + last_name
  end


  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  end

  def self.from_omniauth(auth)
    User.where(provider: auth["provider"], uid: auth["uid"]).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    full_name = auth["info"]["name"]
    full_name_array = full_name.split(" ")
    first_name = full_name_array[0]
    last_name = full_name_array[-1]

    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.profile_name = auth["info"]["nickname"]
      user.first_name = first_name
      user.last_name = last_name
    end
  end

#   def self.new_with_session(params, session)
#     if session["devise.user_attributes"]
#       new(session["devise.user_attributes"], without_protection: true) do |user|
#         user.attributes = params
#         user.valid?
#       end
#     else
#       super
#     end
#   end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

end
