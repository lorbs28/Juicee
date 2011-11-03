# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
    user.first_name "Jane"
    user.last_name  "Doe"

    #user.user_name "hellojane8989"
    #user.email "somerandomemail@email.com"

    # Using #{rand()}.to_s for user_name and email to give them unique values
    # each time the factory for user is used.
    user.user_name "username#{rand(100).to_s}"
    user.email "user_#{rand(1000).to_s}@factories.com"

    user.password              "foobar123"
    user.password_confirmation "foobar123"
end



#Factory.define :bookmark do |bookmark|
#  bookmark.url "www.yahoo.com"
#  bookmark.name "yahoo.com"
#  bookmark.association :user
#end

