class Memo
  attr_reader :id, :title, :description, :url

  def initialize(id, title, description, url)
    @id = id
    @title = title
    @description = description
    @url = url
  end

  def to_hash
    {
      id: id,
      title: title,
      description: description,
      url: url
    }
  end

  def self.find(id)
    all.find do |memo|
      memo.id == id.to_i
    end
  end

  def self.all
    @all ||= [
      Memo.new(1, "First memo", "First description", "https://hogehoge.com"),
      Memo.new(2, "Second memo", "Second description", "https://fugafuga.com")
    ]
  end
end
