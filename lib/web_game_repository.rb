class WebGameRepository

  def self.register(type, repo)
    repositories[type] = repo
  end

  def self.repositories
    @repositories ||= {}
  end

  def self.for(type) 
    repositories[type]
  end

  def self.current_game
    @game
  end

end