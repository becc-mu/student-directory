require 'csv'
@students = [] # an empty array accessible to all methods

def start_program
  try_load_students
  interactive_menu
end

def interactive_menu
  loop do
    print_menu
    process_user_selection(STDIN.gets.chomp)
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to file"
    puts "4. Load the list from file "
    puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_student_list(group_by_cohort)
  print_footer
end

def process_user_selection(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    puts "Enter file name to save as"
    filename = STDIN.gets.chomp
    save_students(filename)
    puts "Saved to #{filename}"
  when "4"
    puts "Enter the file name you want to load"
    filename = STDIN.gets.chomp
    load_students(filename)
    puts "Loaded from #{filename}"
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  while true do
    name = STDIN.gets.chomp.capitalize
    break if name.empty?
    puts "Add student's cohort"
    cohort = STDIN.gets.chomp.capitalize
    cohort = "november" if cohort.empty?
    add_students(name, cohort)
    print_students_count(@students_count)
  end
    @students
end

def print_students_count(students_count)
  if @students.count == 1
    puts "Now we have #{@students.count} student"
  else
   puts "Now we have #{@students.count} students"
 end
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "-------------".center(40)
end

def group_by_cohort
  grouped = {}
  @students.each { |n|
  if grouped.keys.include? n[:cohort]
    grouped[n[:cohort]].push(n[:name])
  else
    grouped[n[:cohort]] = [n[:name]]
  end
  }
  return grouped
end

def print_student_list(grouped)
  grouped.each { |cohort, names|
    puts "#{cohort} cohort: ".center(40)
    names.each { |name| puts name.center(40) }
    puts " "
  }
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students(filename)
  # opent CSV file for writting
  CSV.open("#{filename}", "w") { |file|
   @students.each { |student|
     student_data = [student[:name], student[:cohort]]
     file << student_data
   }
 }
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) { |line|
    name, cohort = line
    add_students(name, cohort)
  }
end

def try_load_students
  filename = ARGV.first # first agrument from the command ling
  #return if filename.nil? #get out of the menthod if it isn't given
  return if filename.nil?
  if File.exists?(filename)
  load_students(filename)
   puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end
start_program
