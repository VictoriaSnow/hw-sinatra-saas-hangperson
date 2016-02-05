class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError unless !letter.nil? && letter =~ /[a-zA-Z]/
    letter = letter.downcase
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    else
      if @word.include?(letter)
        @guesses += letter
      else
        @wrong_guesses += letter
      end
    end
    return true
  end
  
  def word_with_guesses
    displayed = ''
    @word.split('').each do |letter|
      if @guesses.include?(letter)
        displayed += letter
      else
        displayed += '-'
      end
    end
    return displayed
  end
  
  def check_win_or_lose
    if @wrong_guesses.length < 7
      if @word.eql?(self.word_with_guesses)
        return :win
      else
        return :play
      end
    end
    return :lose
  end

      


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
