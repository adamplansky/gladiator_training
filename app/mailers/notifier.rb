class Notifier < ApplicationMailer


   def password_reset(user)
     @user = user
     mail(to: user.email, subject: "Password reset")
   end

   def race_registration(user)
     puts user.inspect
     @u = user
     mail(to: "#{user.email},adamplansky@seznam.cz,hege8400@seznam.cz,jiricimler@centrum.cz", subject: "registrace Gladiator Challenge")
   end

end
