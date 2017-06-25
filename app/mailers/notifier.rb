class Notifier < ApplicationMailer


   def password_reset(user)
     @user = user
     mail(to: user.email, subject: "Password reset")
   end

   def race_registration(user)
     puts user.inspect
     @u = user
     mail(to: "#{user.email}", subject: "registrace Gladiator Challenge")
   end

   def race_registration_direct(user, email)
     puts user.inspect
     @u = user
     mail(to: email, subject: "registrace Gladiator Challenge")
   end

end
