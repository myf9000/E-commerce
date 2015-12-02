module MailboxHelper
  def unread_messages_count
    # how to get the number of unread messages for the current user
    # using mailboxer
    current_user.mailbox.receipts.where(:is_read => false).count
  end
end
