require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing"
    @client = JumpstartAuth.twitter
  end
  
  def tweet(message)
    if short_enough?(message)
      @client.update(message)
    else
	  puts "That message is too long to tweet.  Sorry, try again.  "
    end
  end
  
  def dm(user, message)
  	
  end
  
  def run 
  	puts "Welcome to Ruth's mediocre Twitter Client!!"
  	
  	command = ""
    while command != "quit"
      printf "enter command: "
      input = STDIN.gets.chomp.split(" ")
      command = input[0]

      case command
      	when "quit" then puts "Goodbye!"
        when "tweet" then tweet(input[1..-1].join(" "))
        when "direct" then dm(parts[1], parts[2..-1].join(" "))
      	else puts "Sorry, I don't know now to #{command}"
      end
    end
  end

  def short_enough?(string)
    string.length < 140
  end
end

if __FILE__ == $PROGRAM_NAME

	blogger = MicroBlogger.new
	blogger.run

end