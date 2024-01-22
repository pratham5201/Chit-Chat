json.extract! userchat, :id, :message, :sender, :receiver, :user_id, :username, :created_at, :updated_at
json.url userchat_url(userchat, format: :json)
