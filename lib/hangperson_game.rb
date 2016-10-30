class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :guesses
  attr_accessor :word
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '--------------------------------------'[0..word.length-1]
  end
  
  def guess(l) 
    if l == nil || l == '' || l[/[a-zA-Z]+/]  != l
      raise (ArgumentError)
    end
    if (@word.downcase.include? l.downcase) 
      if @guesses.include? l.downcase
        return false
      end
      @guesses = @guesses + l.downcase
      for i in 0...@word.length
        if l == @word[i]
          @word_with_guesses[i] = l
        end
      end
      return true
    elsif @wrong_guesses.downcase.include? l.downcase 
      return false
    else
      @wrong_guesses = @wrong_guesses + l.downcase
      return true
    end
    check_win_or_lose
  end
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    else
      for i in 0...@word.length
        if !@guesses.include? @word[i]
          return :play
        end
      end
      return :win
    end
  end
      
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
