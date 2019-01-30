class CommentNotifier < ApplicationMailer
  def created(comment, user)
    @comment = comment
    @user = user
    @tickete = comment.tickete
    @project = @tickete.project

    subject = "[ticket] #{@project.name} - #{@tickete.name}"
    mail(to: user.email, subject: subject)
  end
end
