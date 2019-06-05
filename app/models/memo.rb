class Memo
  attr_reader(
    :id, :title, :name, :description, :url
  )

  def initialize(id, title, name, description, url)
    @id = id
    @title = title
    @name = name
    @description = description
    @url = url
  end

  def to_hash
    {
      id: id,
      title: title,
      name: name,
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
      Memo.new(1, "First memo", "First name", "First description", "https://hogehoge.com"),
      Memo.new(2, "Second memo", "Second name", "Second description", "https://fugafuga.com")
    ]
  end

  def self.save
    # TODO:
    true
  end
end
