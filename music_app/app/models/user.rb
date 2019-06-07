class User < ApplicationRecord
    
    # right before we save, we are going to check 
    # that the session_token exists 

    # validations are run on save! 
    
    before_validation :ensure_session_token 

    def generate_session_token 
        self.session_token = SecureRandom::urlsafe_base64 
        self.save! 
    end

    def reset_session_token! 
        self.session_token = SecureRandom::urlsafe_base64 
        self.save!
        self.session_token 
    end

    def ensure_session_token 
        self.session_token ||= SecureRandom::urlsafe_base64 
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password 
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user && user.is_password?(password)
            user 
        else
            nil 
        end
    end
end