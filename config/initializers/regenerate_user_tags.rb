module RegenerateUserTags
  def self.perform
    all_users = User.all;
    for user in all_users
      generate_tag (user)
    end
  end

  def self.generate_tag (user)
    #Fetch user's bought deal count
    deal_purchased = Order.where(:user => user).count
    #Fetch reviews
    comments = Comment.where(commentator: user)
    no_of_likes = 0
    no_of_spams = 0
    for comment in comments
      no_of_likes += comment.users_have_marked_as_liked.count
      no_of_spams += comment.users_have_marked_as_spam.count
    end
    total_comments_posted = comments.count
    # how many people are following the user
    followers = user.no_of_followers#user.users_have_marked_as_following
    #how many pecople this user is following
    following = user.no_of_followings#User.marked_as :following, :by => user

    puts 'User: ' + user.id.to_s + '####### total deals: ' + deal_purchased.to_s + ' total comments: ' + total_comments_posted.to_s +
             ' total followers: ' + followers.to_s + ' following: ' + following.to_s + ' no_of_likes: ' + no_of_likes.to_s

    #Assign points based on the above data
    #multiply the no of deals purchased / 2 by no of reviews. We want this user to buy the deals also not only write the reviews
    weight = 1
    weight = deal_purchased * 2
    #now add the no of comments
    weight += total_comments_posted*1.5
    #ratio of comments and likes
    weight +=  (no_of_likes*no_of_likes/total_comments_posted)
    weight +=  no_of_likes
    weight -=  no_of_spams*3
    weight += followers*1.5
    weight += following*0.5

    puts 'Total points: ' + weight.to_s
    badge = 'beginner'
    if weight > 100 && weight <= 200
      badge = 'enlightened'
    elsif weight > 200 && weight <= 300
      badge = 'scholar'
    elsif weight > 300 && weight < 500
      badge = 'guru'
    elsif weight >= 500
      badge = 'pundit'
    end

    puts 'Badge: ' + badge
    user.badge = badge
    user.save
    if user.save
      puts 'Saved user badge'
    else
      puts 'Error occurred while saving the badge for user'
    end

  end
end

#RegenerateUserTags.perform

