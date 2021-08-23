require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

#Acessando banco de dados
class MongoDB
  def initialize
    client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end
=begin
  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(nome, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: nome }, { user: user_id })
  end
=end
end