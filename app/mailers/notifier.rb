class Notifier < ApplicationMailer


   def password_reset(user)
     @user = user
     mail(to: user.email, subject: "Password reset")
   end

   # def ask_email
   #   mail(to: "adamplansky@gmail.com", subject: "gladiator test")
   # end

end
