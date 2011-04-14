class User < ActiveRecord::Base
  #validates_format_of :email, :with => /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  after_destroy :do_not_delete_last_user
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validate :password_non_blank

    def self.facebook_friends(fb_id, access_token)
      p "http://graph.facebook.com/#{fb_id}/friends?access_token=#{access_token}"
      @doc = Net::HTTP.new("graph.facebook.com", 443)
      @doc.use_ssl = true
      @site = @doc.get("/#{fb_id}/friends?access_token=#{access_token}")
      parsed_json = ActiveSupport::JSON.decode(@site.body)
      parsed_json["data"].each do |t|
        p t["id"]
        p t["name"]
      end
      parsed_json
    end

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      expected_pw = encrypt_pw(password, user.pwsalt)
      puts user.hashed_password
      puts expected_pw
      if user.hashed_password != expected_pw
        user = nil
      end
    end
    user
  end
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["extra"]["user_hash"]["email"]
      user.name = auth["extra"]["user_hash"]["name"]
      user.gender = auth["extra"]["user_hash"]["gender"]
      user.birthdate = auth["extra"]["user_hash"]["birthdate"]
    end
  end
  
  def do_not_delete_last_user
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypt_pw(self.password, self.pwsalt)
  end
  
  private
  
  def password_non_blank
    errors.add(:password, "Password cannot be blank") if :password.blank?
  end
  
  def self.encrypt_pw(password, salt)
    string_to_hash = password + "Yo Mama" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.pwsalt = self.object_id.to_s + rand.to_s
  end

  def self.set_access
    @user = User.find(1)
    @user.access_level = 1
    @user.save
    @user2 = User.find(1)
    p @user2
  end

end
