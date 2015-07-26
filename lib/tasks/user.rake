namespace :user do
  task :resend_confirmation => :environment do
    users = User.where('confirmed_at IS NOT NULL')
    users.each do |user|
      user.send_confirmation_instructions
    end
  end
end