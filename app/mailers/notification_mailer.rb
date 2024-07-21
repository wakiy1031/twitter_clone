class NotificationMailer < ApplicationMailer
  def like_notification(notification:)
    @notification = notification
    @like = notification.subject
    mail(to: @notification.user.email, subject: "あなたの投稿がいいねされました")
  end

  def repost_notification(notification:)
    @notification = notification
    @repost = notification.subject
    mail(to: @notification.user.email, subject: "あなたの投稿がリポストされました")
  end

  def comment_notification(notification:)
    @notification = notification
    @comment = notification.subject
    mail(to: @notification.user.email, subject: "あなたの投稿にコメントがつきました")
  end
end
