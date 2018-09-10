class Notifier < ApplicationMailer


   def password_reset(user)
     @user = user
     mail(to: user.email, subject: "Password reset")
   end

   def race_registration(gt_registration)
     puts gt_registration.inspect
     @registration = gt_registration
     @gt_race = @registration.gt_race
     @gt_category = @registration.gt_category
     mail(to: "#{@registration.email}", subject: "registrace Gladiator Challenge")
   end

   def race_registration_direct(gt_registration, email)
     puts gt_registration.inspect
     @registration = gt_registration
     @gt_race = @registration.gt_race
     @gt_category = @registration.gt_category
     mail(to: email, subject: "registrace Gladiator Challenge")
   end

   def race_registration_reminder(gt_registration)
     puts gt_registration.inspect
     @registration = gt_registration
     @gt_race = @registration.gt_race
     @gt_category = @registration.gt_category
     mail(to: "#{@registration.email}", subject: "nezaplacená registrace Gladiator Challenge")
   end


   def error_admin(email, text)
     @error = text
     mail(to: email, subject: "ERROR gladiator training")
   end



end
