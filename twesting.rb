require 'date'

def your_age(age)
  agem = @age[1].to_i
  aged = @age[0].to_i
  date = DateTime.now
  y = date.year.to_i
  d = date.day.to_i
  m = date.month.to_i

  aa = m <= agem  ? 1 : 0
  ab = d >= aged ? 0 : 1
  puts("your name is #{@fname}" + " #{ @lname }  ")
  if m == agem
    puts ("your age is  #{ y - @age[2].to_i - ab } ")  
  else
    puts ("your age is  #{ y - @age[2].to_i - aa}")  
  end

end

def call
  print "Enter your First name  "
  @fname = gets.chomp() 
  print "Enter your last name  "
  @lname= gets.chomp()
  print "Enter your birth year in formate dd/mm/yyyy "
  age = gets.chomp()
  @age = age.split("/")
  your_age(age)
end

call