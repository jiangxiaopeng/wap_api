require 'sinatra'
require File.join(File.dirname(__FILE__),'model')

get '/videos.json' do 
  content_type :json
  type = params[:type]
  pg = params[:pg]
  if pg == nil 
    pg = 1
  end 
  pz = 1
  cid = params[:cid] 
  json = Video.new.api_video(type,cid,pg,pz).to_json
end

get '/videodetail.json' do 
  content_type :json
  vid = params[:vid]
  json = Video.new.api_videodetail(vid).to_json
end
