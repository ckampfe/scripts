require 'debugger'
require 'csv'
require 'date'
require 'yaml'
require 'json'

class Person 

  attr_reader :data, :id, :first_name, :last_name, :email, :phone, :created_date

  def initialize(data = {})
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email = data[:email]
    @phone = data[:phone]
    begin
    @created_date = DateTime.parse(data[:created_date])
    rescue
    @created_date = data[:created_date]
    end
  end
end 


class PersonParser
  attr_reader :file
  attr_accessor :people
  
  def initialize(file)
    @file = file
    @people = nil
  end
  
  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people
    @people = []

    # read 
    CSV.foreach(@file) do |row|
      @people << Person.new(:id => row[0],
                            :first_name => row[1],
                            :last_name => row[2],
                            :email => row[3],
                            :phone => row[4],
                            :created_date => row[5])
    end

  end


   def printer(person)
     [person.id, person.first_name, person.last_name, person.email, person.phone, person.created_date]
   end

  # CSV
  def save(filename)
    CSV.open("#{filename}", 'wb') do |row|
      @people.each do |person|
        row << printer(person)
      end
    end
  end  

  def add_person(person)
    @people << person
  end 
  
  # JSON
  # def save_as_json(filename) 
  #   File.open("#{filename}", 'w') do |file|
  #     @people.each do |person|
  #       file << person.print_json
  #     end
  #   end
  # end

  # substitute JSON#pretty_generate
  # to make each object multiline
  def print_json
    JSON.generate({
          'id' => person.id,
          'first_name' => person.first_name,
          'last_name' => person.last_name,
          'email' => person.email,
          'phone' => person.phone,
          'created_at' => person.created_date
        }) + "\n"
  end

  # YAML
  def save_as_yaml(filename)
    File.open("#{filename}", 'w') do |file|
      @people.each { |person| file << person.to_yaml }
    end
  end
end


parser = PersonParser.new('people.csv')
parser.people
parser.save('clark.csv')

new_parse = PersonParser.new('clark.csv')
new_parse.people
new_parse.save('fresh.csv')

#parser.save('clark.csv')
# parser.save_as_yaml('dingo.yml')
# parser.save_as_json('jsonify.json')

