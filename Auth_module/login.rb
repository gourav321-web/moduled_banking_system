module Login
  def login
    loop do
      print "Enter your Email : "
      @email=gets.chomp.downcase
      if @email.empty?
        puts "please enter Email"
      else
        @email.gsub!(/\s+/ , "")
        break
      end
    end

    loop do
      print "Enter Password : "
      @password=gets.chomp
      if @password.empty?
        puts "please enter Password"
      else
        break  
      end
    end

    found=false
    CSV.foreach("User.csv",headers:true) do |row|
      if row["email"]==@email && row["password"]==@password
        found=true
        @user[:name] = row["name"]
        @user[:email]=row["email"]
        @user[:password] = row["password"]
        @user[:balance]=row["balance"].to_i
        puts "Login Successful."
        break
      end
    end

    puts "Invalid Email or Password!" unless found
  end
end
