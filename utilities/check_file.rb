module Check_file
  def check_file
    unless File.exist?("User.csv")
      CSV.open("User.csv","w") do |csv|
        csv << ["name","email","password","balance"]
      end
    end
  end
end