# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def notification_email(notification:)
    @notification = notification
    @subject = notification.subject

    subject = case @notification.subject_type
              when 'Like'
                'あなたの投稿がいいねされました'
              when 'Repost'
                'あなたの投稿がリポストされました'
              when 'Comment'
                'あなたの投稿にコメントがつきました'
              else
                '新しい通知があります'
              end

    mail(to: @notification.user.email, subject:)
  end
end
