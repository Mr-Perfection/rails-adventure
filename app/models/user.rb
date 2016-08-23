class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
    # before_save {self.email = email.downcase}
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true 
   
    #returns the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64 #generates a random token for the cookie
    end
    
    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    
    # returns true if the given token matches the digest (remember_digest, activation_digest)
    def authenticated?(attribute, token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)        #renew the remember_digest with new password
    end
    
    # forget the user by setting nil to remember digest
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    # activate an account
    def activate
        update_columns(activated: true, activated_at: Time.zone.now)
    end
    
    # send activation email
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end
    
    # Sets the password reset attributes.
    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
        # update_attribute(:reset_digest, User.digest(reset_token))
        # update_attribute(:reset_sent_at, Time.zone.now) 
    end
    
    # Sends password reset email.
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end
    
    # Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    #before filters
    private
    
    #convert email to all lowercase letters
    def downcase_email
        # self.email = email.downcase
        email.downcase!
    end
    
    #creates and assigns the activation token and digest.
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end
