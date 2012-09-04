require 'kaminari/sinatra'
require 'active_record'
require "yaml"
ActiveRecord::Base.establish_connection YAML::load(IO.read 'db/database.yml')[ENV['ENV'] || 'development' || 'production']

class Video < ActiveRecord::Base
  # 视频列表
  def api_video(type,cid,pg,pz)
    if cid != nil && !cid.eql?("")
      total = Video.where(:video_type=>type,:cid=>cid).count
      videos = Video.where(:video_type=>type,:cid=>cid).page(pg).per(pz)
    else 
      total = Video.where(:video_type=>type).count
      videos = Video.where(:video_type=>type).page(pg).per(pz)  
    end
    json = video_hash(videos,total)
    json
  end

  def video_hash(videos,total)
    hash = {}
    hash.store("results", video_array(videos))
    hash.store("total", total)
    hash
  end

  def video_array(videos)
    array = []
    videos.each do |video|
      array.push(_video_hash(video))
    end
    array
  end

  def _video_hash(video)
    hash={}
    hash.store("videoid", video.video_id)
    hash.store("title", video.title)
    hash.store("img", video.video_img)
    hash.store("director", video.video_director)
    hash.store("performer", video.video_performer)
    hash.store("time", video.video_time)
    hash.store("size", video.video_size)
    hash.store("focus", video.video_focus)
    hash.store("source", video.video_source)
    hash.store("url", video.video_url)
    hash.store("original_price", video.original_price)
    hash.store("privilege_price", video.privilege_price)
    hash
  end
  #视频详情 
  def api_videodetail(vid) 
    video = Video.find_by_video_id(vid)  
    json = videodetail_hash(video)
    json
  end  
  
  def videodetail_hash(video)
    hash = {}
    hash.store("results", _videodetail_hash(video))
    hash
  end

  # def videodetail_array(videos)
  #    array = []
  #    videos.each do |video|
  #      array.push(_videodetail_hash(video))
  #    end
  #    array
  #  end
 
  def _videodetail_hash(video)
    hash={}
    hash.store("videoid", video.video_id)
    hash.store("title", video.title)
    hash.store("img", video.video_img)
    hash.store("director", video.video_director)
    hash.store("performer", video.video_performer)
    hash.store("time", video.video_time)
    hash.store("size", video.video_size)
    hash.store("focus", video.video_focus)
    hash.store("source", video.video_source)
    hash.store("url", video.video_url)
    hash.store("original_price", video.original_price)
    hash.store("privilege_price", video.privilege_price)
    hash
  end
end
