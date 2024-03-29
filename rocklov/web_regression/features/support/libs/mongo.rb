require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

#Acessando banco de dados
class MongoDB
  attr_accessor :client, :equipos, :users

  def initialize
    @client = Mongo::Client.new(CONFIG["mongo"])
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(nome, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: nome }, { user: user_id })
  end
end
