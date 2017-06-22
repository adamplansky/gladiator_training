class Notifier < ApplicationMailer


   def password_reset(user)
     @user = user
     mail(to: user.email, subject: "Password reset")
   end

   def race_registration(user)
     puts user.inspect
     @u = user
     mail(to: user.email, subject: "Potvrzení registrace Gladiator Challenge")
     mail(to: "adamplansky@gmail.com", subject: "registrace Gladiator Challenge")
     mail(to: "hege8400@seznam.cz", subject: "registrace Gladiator Challenge")
     mail(to: "jiricimler@centrum.cz", subject: "registrace Gladiator Challenge")

   end

end
