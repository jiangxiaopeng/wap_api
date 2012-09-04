require 'sinatra'
require File.join(File.dirname(__FILE__),'model/video')
require File.join(File.dirname(__FILE__),'model/stat')

get '/videos.json' do 
  content_type :json
  type = params[:type]
  pg = params[:pg]
  if pg == nil 
    pg = 1
  end 
  pz = 6
  cid = params[:cid] 
  json = Video.new.api_video(type,cid,pg,pz).to_json
end

get '/videodetail.json' do 
  content_type :json
  vid = params[:vid]
  json = Video.new.api_videodetail(vid).to_json
end

get '/stat.json' do 
  content_type :json
  vid = params[:vid]
  json = Stat.new.api_stat(vid).to_json
end 