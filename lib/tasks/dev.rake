# encoding: utf-8
namespace :dev do

  desc "Rebuild system"
  task :rebuild => ["db:drop", "db:create", "db:migrate", "db:seed"]

  desc "Setup fake data"
  task :fake => :environment do
      User.delete_all
      Post.delete_all
      Comment.delete_all
      Vote.delete_all

      puts "Create first user and users posts, comments and votes."
      user = User.create!(username: "User1", password: "pw")
      1.upto(10) do |x|
        post = user.posts.create!(title: "post #{x}", url: "url #{x}", description: "desc #{x}")
        comment = post.comments.create!(body: "comment #{x}", creator: user)
        Vote.create(vote: true, voteable: post, creator: user)
        Vote.create(vote: true, voteable: comment, creator: user)
      end

      puts "Create second user."
      User.create!(username: "User2", password: "pw")

      puts "Create third user."
      User.create!(username: "User3", password: "pw")
  end
end