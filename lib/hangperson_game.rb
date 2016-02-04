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
    raise ArgumentError if letter == nil || letter.empty? || (letter =~ /[a-zA-Z]/).nil?
    if !(letter =~ /[A-Z]/).nil?
      return false
    end
    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses += letter
    elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
      @wrong_guesses += letter
    else
      return false
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
    if @guesses.length + @wrong_guesses.length < 7
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
