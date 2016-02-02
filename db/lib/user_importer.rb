class UserImporter

  def import
    puts "adding users..."
    User.transaction do

      User.create(username: "Kendawgg", 
                  first_name: "Kenny", 
                  last_name: "Wu", 
                  password: "1234", 
                  address: "12345 baker street", 
                  rating: 0, 
                  email: "kenny@gmail.com")
      User.create(username: "Big D", 
                  first_name: "Dennis", 
                  last_name: "Marchand", 
                  password: "1234", 
                  address: "45565 maker street", 
                  rating: 0, 
                  email: "dennis@gmail.com")
      User.create(username: "The S", 
                  first_name: "Sam", 
                  last_name: "Collis", 
                  password: "1234", 
                  address: "873678 quaker street", 
                  rating: 0, 
                  email: "sam@gmail.com")

    end
    puts "done adding users."
  end
end