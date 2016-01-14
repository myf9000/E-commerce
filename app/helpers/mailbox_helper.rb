module MailboxHelper
  def unread_messages_count
    current_user.mailbox.receipts.where(:is_read => false).count
  end
end
