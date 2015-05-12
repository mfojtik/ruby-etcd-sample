require 'bundler'
Bundler.require :default

class SampleApp < Sinatra::Base

  helpers do

    def etcd_url
      "etcd:2379"
    end

    def etcd
      Etcd.client(
        host: 'etcd',
        port: '2379'
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
