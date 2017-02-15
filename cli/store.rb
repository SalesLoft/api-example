require 'yaml/store'

class Store
  STORE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../credentials.store"))

  def initialize
    @store = YAML::Store.new(STORE_PATH)
  end

  def transaction
    @store.transaction do
      yield
    end
  end

  def expires_at
    @store[:credentials]["expires_at"]
  end

  def expires_at=(val)
    @store[:credentials]["expires_at"] = val
  end

  def token
    @store[:credentials]["token"]
  end

  def token=(val)
    @store[:credentials]["token"] = val
  end

  def refresh_token
    @store[:credentials]["refresh_token"]
  end

  def refresh_token=(val)
    @store[:credentials]["refresh_token"] = val
  end
end
