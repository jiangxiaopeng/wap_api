require 'kaminari/sinatra'
require 'active_record'
require "yaml"
ActiveRecord::Base.establish_connection YAML::load(IO.read 'db/database.yml')[ENV['ENV'] || 'development' || 'production']

class Stat < ActiveRecord::Base
  #统计 
  def api_stat(vid) 
    stat = Stat.find_by_video_id(vid)
    json = stat_hash(stat)
    json
  end
  
  def stat_hash(stat)
    hash = {}
    hash.store("results", _stat_hash(stat))
    hash
  end

  def _stat_hash(stat)
    hash={}
    hash.store("videoid", stat.video_id)
    hash.store("title", stat.title)
    hash.store("purchase_count", stat.purchase_count)
    hash.store("play_count", stat.play_count)
    hash
  end
end
