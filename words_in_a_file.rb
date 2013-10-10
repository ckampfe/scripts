### README ###
#
# To use:
#
# run in this format `words_in_a_file.rb /your/file.txt N` ,
# where N is the Top-N number of words you wish to display.

# constants
NUMS = (0..2020).to_a.map { |num| num.to_s }
TEXT = File.open(ARGV[0], 'r') { |l| l.read }
WORDS = TEXT.split(/\W+/)
LITTLE_WORDS = ["he", "as", "been", "also", "their", "her", "that", "were", "ref", "are", "has", "him", "who", "but", "isbn", "its", "it\'s", "which", "from", "his", "was", "by", "for", "may", "had", "or", "this", "she", "a", "The", "they", "the", "them", "it", "though", "of", "and", "an", "with", "else", "in"]

def word_counter
  word_count = Hash.new(0)
  
  # counter
  WORDS.each do |word|
    word_count[word] += 1 unless (word.length <= 2 || LITTLE_WORDS.include?(word) || NUMS.include?(word))
  end

  # return WORDS that have a count of 10 or greater; sort them by their count; reverse.
   word_count.select { |word, count| count >= 10 }.sort_by { |word, count| count }.reverse
end

def list_disp(a_wordlist)
  y = 0
  
  # marches through a 2D array
  # until it reaches the user's given limit 
  while y < ARGV[1].to_i
    x = 0
    puts "\'#{a_wordlist[y][x]}\': #{a_wordlist[y][x+1]} occurrences"
    y += 1
  end
end


list_disp(word_counter)
