@month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv "
    puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_student_list
  print_footer
end


def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp.capitalize
  while !name.empty? do
    puts "Please enter the student's cohort"
    cohort = STDIN.gets.chomp.capitalize
    cohort = add_cohort(cohort) if cohort.empty?
    @students << {name: name, cohort: cohort.to_sym }
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def push_students_to_array
  @students << {name: name, cohort: cohort.to_sym }
end


def add_cohort(cohort_mth)
  cohort_mth = cohort_mth.empty? ? "november" : cohort_mth.downcase
  # check if cohort_mth is one of the 12 months
  selected_cohrt = %w(january feburary march april may june july august september october november december)
  if selected_cohrt.include? cohort_mth
    return cohort_mth
  else
    return selected_cohrt[rand(12)] # else send a random month
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  max_n = 12
  space = 15
  count = 1
  until count > @students.count
    @students.each.with_index(1) do |student, i|
      if student[:name].size < max_n
        puts "#{i}. #{student[:name].center(space)} (#{student[:cohort]} cohort)"
        count += 1
      end
    end
  end
end

def group_by_cohort(students)
  group_by_cohort = students.map do |student|
    student[:cohort]
  end.uniq
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  # opent the file for writting
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  puts "Enter the file name you want to load"
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
  $student_name = name
  push_students_to_array
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first agrument from the command ling
  return if filename.nil? #get out of the menthod if it isn't given
  if File.existis?(filename)
    load_students(filename)
    puts "Loaded #{@students.count}from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

data = __FILE__
puts File.read(data)
try_load_students
interactive_menu
