crumb :root do
  link "Index", root_path
end

crumb :product do |f|
  link f.title
  parent :root
end

crumb :inbox do |f|
  link "Inbox", mailbox_inbox_path
  parent :root
end

crumb :sent do |f|
  link "Sent", mailbox_sent_path
  parent :root
end

crumb :trash do |f|
  link "Trash", mailbox_trash_path
  parent :root
end

crumb :conversation do |f|
  link "Conversation", conversation_path
  parent :inbox
end

crumb :new_conversation do |f|
  link "New conversation", new_conversation_path
  parent :inbox
end

crumb :order do |f|
  link "Order", order_path
  parent :root
end

crumb :user do |f|
  link f.email, user_path
  parent :root
end

