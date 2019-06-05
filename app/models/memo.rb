class Memo
  attr_reader :id, :title, :description

  def initialize(id, title, description)
    @id = id
    @title = title
    @description = description
  end

  def to_hash
    {
      id: id,
      title: title,
      description: description
    }
  end

  def self.find(id)
    all.find do |memo|
      memo.id == id.to_i
    end
  end

  def self.all
    @all ||= [
      Memo.new(1, "First memo", "First description"),
      Memo.new(2, "Second memo", "Second description")
    ]
  end
end
