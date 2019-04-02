namespace :stats do
  desc "Show all registrations"
  task :registrations => :environment do
    Team.all.includes(:users).each do |team|
      puts "#{team.name} #{team.status.to_s} (#{team.created_at.to_s})"
      team.users.each do |user|
        printf("  %-30s %-30s (%s)\n", user.name, user.email, user.status.to_s)
      end
    end

  end
end