require 'digest/sha2'

#This class deals with adding student accounts to Study Buddy
class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
 
  #check that password and confirm password form fields match (i.e. same password entered in twice)
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

  validate  :password_must_be_present
  
 #return student object if correct username and password is supplied
  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

#Create a hashed password for the student to be stored in the database
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "ATeam" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
#check that password has been set
  private
  
  def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
  
#create salt string to protect/encrypt student's password
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
