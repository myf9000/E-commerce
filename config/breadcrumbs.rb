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


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).