class SocialMedia
  attr_accessor :linkedin, :facebook, :instagram, :github, :whatsapp, :x

  def initialize(values)
    social_networks = values ? sanitize_string(values) : [nil, nil, nil, nil, nil, nil]
    @linkedin = social_networks[0]
    @facebook = social_networks[1]
    @instagram = social_networks[2]
    @github = social_networks[3]
    @whatsapp = social_networks[4]
    @x = social_networks[5]
  end

  def sanitize_string(values)
    values.delete('()').split(',')
  end

  def to_s
    "(#{linkedin},#{facebook},#{instagram},#{github},#{whatsapp},#{x})"
  end
end
