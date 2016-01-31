namespace :paylow_scheduled_task do
  desc 'This task runs at 12 am daily to re generate the use tags'
  task define_user_tags: :environment do
    puts 'I am a scheduled task handled via whenever scheduler'
    RegenerateUserTags.perform
  end

end
