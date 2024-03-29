require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

#Acessando banco de dados
class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger #metodo para excluir todos os usuário no banco
    @client.database.drop
  end

  def insert_users(docs) # metodo para inserir toda massa de dados do arquivo helpers
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(nome, user_id)
    obj_id = BSON::ObjectId.from_string(user_id) #covertendo para object_id do mongo
    @equipos.delete_many({ name: nome, user: obj_id })
  end

  #gerando id aleatorio para fazer consulta no banco por equipamento invalido
  def get_mongo_id
    return BSON::ObjectId.new
  end
end
