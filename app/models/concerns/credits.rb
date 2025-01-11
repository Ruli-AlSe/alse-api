class Credits
  attr_accessor :link_url, :page_name, :user_name

  def initialize(values)
    credits = values ? sanitize_string(values) : ['', '', '']
    @link_url = credits[0]
    @page_name = credits[1]
    @user_name = credits[2]
  end

  def sanitize_string(values)
    values.delete('()').split(',').map(&:to_s)
  end

  def to_s
    "(#{link_url},#{page_name},#{user_name})"
  end
end
