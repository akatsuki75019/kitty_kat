class UserMailer < ApplicationMailer
    def bienvenue_email(user)
        @user = user
        mail(to: @user.email, subject: 'Bienvenue chez nous !')
      end
end
