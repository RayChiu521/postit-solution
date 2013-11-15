# encoding: utf-8
namespace :dev do

  desc "Rebuild system"
  task :rebuild => ["db:drop", "db:create", "db:migrate", "db:seed"]

  desc "Setup fake data"
  task :fake => :environment do
      puts "Create a default user"
      user = User.create!(username: "User1", password: "pw")
      puts "Create a post"
      post = user.posts.create!(title: "a post", url: "some.url", description: "some desc")
      puts "Create a comment"
      post.comments.create!(body: "a comment", creator: user)
  end
end