require 'bundler'
Bundler.require :default

class SampleApp < Sinatra::Base

  helpers do

    def etcd_url
      "#{ENV['ETCD_SERVICE_HOST']}:#{ENV['ETCD_SERVICE_PORT']}"
    end

    def etcd
      Etcd.client(
        host: ENV['ETCD_SERVICE_HOST'],
        port: ENV['ETCD_SERVICE_PORT']
      )
    end

  end

  get '/' do
    "Key '/sample/time' on #{etcd_url} is: #{etcd.get('/sample/time').value}"
  end

  get '/set' do
    current_time = Time.now.to_s
    etcd.set('/sample/time', value: current_time)
    "Key '/sample/time' on #{etcd_url} set to #{current_time}"
  end

end

run SampleApp
